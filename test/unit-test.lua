local UnitTest = { StepCounter = 1 }

function UnitTest.Start(name)
    UnitTest.Name = name
end

function UnitTest.Compare(resulted_value, expected_value, almost_equal)
    local ERR = '[TEST FAILED]: ' .. UnitTest.Name .. ' at test #' .. UnitTest.StepCounter .. '. Expected ' .. tostring(expected_value) .. ', got ' .. tostring(resulted_value)
    if almost_equal then
        assert(math.abs(resulted_value - expected_value) <= 1e-9, ERR)
    else
        assert(resulted_value == expected_value, ERR)
    end
    UnitTest.StepCounter = UnitTest.StepCounter + 1
end

function UnitTest.Finish()
    print('[TEST SUCCEED]: ' .. UnitTest.Name .. ' (' .. UnitTest.StepCounter - 1 .. ' tests)')
    UnitTest.Name = nil
    UnitTest.StepCounter = 1
end

return UnitTest