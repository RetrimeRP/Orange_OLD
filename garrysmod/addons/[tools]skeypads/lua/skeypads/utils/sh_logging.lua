sKeypads.Utils = sKeypads.Utils or {}

function sKeypads.Utils.log(err)
    sKeypads.Utils.checkType(err, sKeypads.Types.TYPE_STRING )
    print("Superior Keypads: " .. err)
end
