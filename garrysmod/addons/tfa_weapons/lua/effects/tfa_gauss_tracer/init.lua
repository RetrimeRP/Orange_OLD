EFFECT.Mat = Material( "effects/pfx_light3" )
EFFECT.Mat2 = Material( "effects/pfx_anomaly_8_trail" )

function EFFECT:Init( data )

	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()

	-- Keep the start and end pos - we're going to interpolate between them
	self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )
	self.EndPos = data:GetOrigin()

	self.Alpha = 255
	self.Life = 0

	self:SetRenderBoundsWS( self.StartPos, self.EndPos )

end

function EFFECT:Think()

	self.Life = self.Life + FrameTime() * 3
	self.Alpha = 255 * ( 1 - self.Life )

	return ( self.Life < 1 )

end

function DrawParticlesOnLine(startPos, endPos)
    local numParticles = math.max(startPos:Distance(endPos)/25,5)
    local stepSize = 1 / (numParticles + 1)
	local emitter = ParticleEmitter( startPos )
    for i = 1, numParticles do
		local t = i * stepSize
        local particlePos = LerpVector(t, startPos, endPos)
		local part = emitter:Add( "effects/pfx_anomaly_8", particlePos )
		if ( part ) then
			part:SetDieTime( 0.25 )
			part:SetStartAlpha( 150 )
			part:SetEndAlpha( 0 )
			part:SetStartSize( 20 )
			part:SetEndSize( 0 )
			part:SetRoll(math.Rand(-50,50))
			part:SetRollDelta(1)
		end
		local part2 = emitter:Add( "effects/pfx_light3", particlePos )
		if ( part2 ) then
			part2:SetDieTime( 0.2 )
			part2:SetStartAlpha( 255 )
			part2:SetEndAlpha( 0 )
			part2:SetStartSize( 10 )
			part2:SetEndSize( 0 )
			part2:SetRoll(math.Rand(-50,50))
		end
		local part3 = emitter:Add( "effects/spark", particlePos )
		if ( part3 ) then
			part3:SetDieTime( 0.3 )
			part3:SetStartAlpha( 255 )
			part3:SetEndAlpha( 255 )
			part3:SetStartSize( 5 )
			part3:SetEndSize( 0 )
			part3:SetRoll(math.Rand(-50,50))
			part3:SetRollDelta(1)
			part3:SetColor(60,60,85)
			part3:SetGravity(VectorRand()*50*Vector(1,0,1))
			part3:SetVelocity( VectorRand()*50 )
		end
    end
end

function LerpVector(t, startPos, endPos)
    return startPos + (endPos - startPos) * t
end

function EFFECT:Render()

	if ( self.Alpha < 1 ) then return end

	render.SetMaterial( self.Mat )
	local texcoord = math.Rand( 0, 1 )

	local norm = (self.StartPos - self.EndPos) * self.Life

	self.Length = norm:Length()

	--[[for i = 1, 3 do

		render.DrawBeam( self.StartPos - norm,		-- Start
					self.EndPos,					-- End
					20,								-- Width
					texcoord,						-- Start tex coord
					texcoord + self.Length / 128,	-- End tex coord
					color_white )		-- Color (optional)
	end]]--


	DrawParticlesOnLine(self.StartPos, self.EndPos)
	render.DrawBeam( self.StartPos,
					self.EndPos,
					15,
					texcoord,
					texcoord + ( ( self.StartPos - self.EndPos ):Length() / 128 ),
					Color( 255, 255, 255, 255 * ( 1 - self.Life ) ) )
	for i = 1, 3 do
	render.DrawBeam( self.StartPos,
					self.EndPos,
					15,
					texcoord,
					texcoord + self.Length / 128,
					Color( 150, 150, 150, 255 * ( 1 - self.Life ) ) )
	render.SetMaterial( self.Mat2 )
	end
end

