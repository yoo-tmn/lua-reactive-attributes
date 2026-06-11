local Test = { StepCounter = 1 }

function Test.Start(name)
    Test.Name = name
end

function Test.Compare(resulted_value, expected_value, almost_equal)
    local ERR = '[TEST FAILED]: ' .. Test.Name .. ' at test #' .. Test.StepCounter .. '. Expected ' .. tostring(expected_value) .. ', got ' .. tostring(resulted_value)
    if almost_equal then
        assert(math.abs(resulted_value - expected_value) <= 1e-9, ERR)
    else
        assert(resulted_value == expected_value, ERR)
    end
    Test.StepCounter = Test.StepCounter + 1
end

function Test.Finish()
    print('[TEST SUCCEED]: ' .. Test.Name .. ' (' .. Test.StepCounter - 1 .. ' tests)')
    Test.Name = nil
    Test.StepCounter = 1
end

return Test