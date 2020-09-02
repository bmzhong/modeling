function config = configuration(defaultConfig,userConfig)

    % Initialize the configuration structure as the default
    config = defaultConfig;

    % Extract the field names of the default configuration structure
    defaultFields = fieldnames(defaultConfig);

    % Extract the field names of the user configuration structure
    userFields = fieldnames(userConfig);
    nUserFields = length(userFields);

    % Override any default configuration fields with user values
    for i = 1:nUserFields
        userField = userFields{i};
        isField = strcmpi(defaultFields,userField);
        if nnz(isField) == 1
            thisField = defaultFields{isField};
            config.(thisField) = userConfig.(userField);
        end
    end

end