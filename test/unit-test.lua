local UnitTest = { StepCounter = 1 }

function UnitTest.Start(name)
    UnitTest.Name = name
end

function UnitTest.Check(result, next_step)
    assert(result, '[TEST FAILED]: ' .. UnitTest.Name .. ' at step #' .. UnitTest.StepCounter)
    if next_step or next_step == nil then
        UnitTest.StepCounter = UnitTest.StepCounter + 1
    end
end

function UnitTest.Compare(resulted_value, expected_value, almost_equal)
    local ERR = '[TEST FAILED]: ' .. UnitTest.Name .. ' at step #' .. UnitTest.StepCounter .. ' Expected ' .. expected_value .. ', got ' .. resulted_value
    if almost_equal then
        assert(math.abs(resulted_value - expected_value) <= 1e-9, ERR)
    else
        assert(resulted_value == expected_value, ERR)
    end
    UnitTest.StepCounter = UnitTest.StepCounter + 1
end

function UnitTest.Finish()
    print('[TEST SUCCEED]: ' .. UnitTest.Name .. ' (' .. UnitTest.StepCounter .. ' steps)')
    UnitTest.Name = nil
    UnitTest.StepCounter = 1
end

return UnitTest