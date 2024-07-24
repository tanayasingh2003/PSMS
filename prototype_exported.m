classdef prototype_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        UITable2                        matlab.ui.control.Table
        GotoLoginPageButton             matlab.ui.control.Button
        BackButton                      matlab.ui.control.Button
        DeleteEmployeeButton            matlab.ui.control.Button
        AddEmployeeButton               matlab.ui.control.Button
        CPFofEmployeeEditField          matlab.ui.control.EditField
        CPFofEmployeeEditFieldLabel     matlab.ui.control.Label
        MemberModificationButton        matlab.ui.control.Button
        EnterProjectDetailsButton       matlab.ui.control.Button
        PlanDateDatePicker              matlab.ui.control.DatePicker
        PlanDateDatePickerLabel         matlab.ui.control.Label
        PRNOEditField                   matlab.ui.control.EditField
        PRNOEditFieldLabel              matlab.ui.control.Label
        TenderTypeTextArea              matlab.ui.control.TextArea
        TenderTypeTextAreaLabel         matlab.ui.control.Label
        NameoftheProjectTextArea        matlab.ui.control.TextArea
        NameoftheProjectTextAreaLabel   matlab.ui.control.Label
        CPFofCoordinatorEditField       matlab.ui.control.EditField
        CPFofCoordinatorEditFieldLabel  matlab.ui.control.Label
        YourCPFEditField                matlab.ui.control.EditField
        YourCPFLabel                    matlab.ui.control.Label
        LoginButton                     matlab.ui.control.Button
        CPFNoEditField                  matlab.ui.control.EditField
        CPFNoEditFieldLabel             matlab.ui.control.Label
        MonthListBox                    matlab.ui.control.ListBox
        MonthListBoxLabel               matlab.ui.control.Label
        ClearRowButton                  matlab.ui.control.Button
        ActualDateDatePicker            matlab.ui.control.DatePicker
        ActualDateDatePickerLabel       matlab.ui.control.Label
        SavetoExcelButton               matlab.ui.control.Button
        ProjectnumberEditField          matlab.ui.control.EditField
        ProjectnumberEditFieldLabel     matlab.ui.control.Label
        FeedButton                      matlab.ui.control.Button
        ListBox2                        matlab.ui.control.ListBox
        Hyperlink                       matlab.ui.control.Hyperlink
        MilestoneEditField              matlab.ui.control.EditField
        MilestoneEditFieldLabel         matlab.ui.control.Label
        ApproxProjectCostINREditField   matlab.ui.control.EditField
        ApproxProjectCostINREditFieldLabel  matlab.ui.control.Label
        UITable                         matlab.ui.control.Table
        COMMUNICATIONGROUPINFOCOMLabel  matlab.ui.control.Label
        Image                           matlab.ui.control.Image
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            % app.UITable.Data = table(rand(m,n), 'VariableNames', {'Column1', 'Column2', ..., 'ColumnN'});
            % newRow = [value1, value2];
            % app.UITable.Data = [app.UITable.Data; newRow];

            t = readtable("C:\Users\tanay\Downloads\table_gui.xlsx");
            app.UITable.Data =t;
        end

        % Value changed function: ListBox2
        function ListBox2ValueChanged(app, event)
            value = app.ListBox2.Value;
            switch (value)
                case 'Select CPF no.'
                    app.MonthListBox.Visible = 'off';
                    app.MonthListBoxLabel.Visible = 'off';
                     app.ProjectnumberEditFieldLabel.Visible = 'off';
                    app.ProjectnumberEditField.Visible = 'off';
                    app.NameoftheProjectTextArea.Visible = 'off';
                    app.NameoftheProjectTextAreaLabel.Visible = 'off';
                    app.CPFofCoordinatorEditField.Visible ="off";
                    app.CPFofCoordinatorEditFieldLabel.Visible ="off";
                    app.TenderTypeTextArea.Visible= 'off';
                    app.TenderTypeTextAreaLabel.Visible= 'off';
                    app.ApproxProjectCostINREditFieldLabel.Visible = 'off';
                    app.ApproxProjectCostINREditField.Visible = 'off';
                    app.MilestoneEditFieldLabel.Visible = 'off';
                    app.MilestoneEditField.Visible = 'off';
                    app.PRNOEditField.Visible='off';
                    app.PRNOEditFieldLabel.Visible='off';
                    app.PlanDateDatePicker.Visible= 'off';
                    app.PlanDateDatePickerLabel.Visible= 'off';
                    app.ActualDateDatePicker.Visible= 'off';
                    app.ActualDateDatePickerLabel.Visible= 'off';
                    app.FeedButton.Visible = 'off';

                otherwise 
                    app.MonthListBox.Visible = 'on';
                    app.MonthListBoxLabel.Visible = 'on';
            end
        end

        % Button pushed function: FeedButton
        function FeedButtonPushed(app, event)
           

            listBoxValue = app.ListBox2.Value;
            listBoxValue = app.ListBox2.Value;
            projectNumber = {app.ProjectnumberEditField.Value};
            projectName = strtrim(app.NameoftheProjectTextArea.Value);
            coordinatorCPF = {app.CPFofCoordinatorEditField.Value};
            tenderType = strtrim(app.TenderTypeTextArea.Value);
            projectCost = {app.ApproxProjectCostINREditField.Value};
            prNo = {app.PRNOEditField.Value};
            milestone = strtrim(app.MilestoneEditField.Value);
            planDate = char(app.PlanDateDatePicker.Value);
            actualDate = char(app.ActualDateDatePicker.Value);
            % Create the newRow2 cell array
            
            newRow2 = [listBoxValue, projectNumber, projectName, coordinatorCPF, tenderType, projectCost, prNo, milestone, planDate, actualDate];
            app.UITable2.Data = [app.UITable2.Data; newRow2];

            app.ProjectnumberEditField.Value ='';
            app.NameoftheProjectTextArea.Value = ' ';
            app.ApproxProjectCostINREditField.Value = '';
            app.MilestoneEditField.Value = '';
            % app.ActualDateDatePicker.Value= '';
            app.UITable.Visible = 'off';
            app.SavetoExcelButton.Visible = 'on';
            app.UITable2.Visible = 'on';
            app.ClearRowButton.Visible = 'on';
           

        end

        % Button pushed function: SavetoExcelButton
        function SavetoExcelButtonPushed(app, event)
      tableData = app.UITable2.Data;
      value = app.MonthListBox.Value;
      %
      % switch (value)
      %     case 'January'
      %
      months = ["January", "February", "March", "April", "May", "June", ...
          "July", "August", "September", "October", "November", "December"];

      [filename, folder] = uiputfile('*.xlsx', 'Save Excel File', "C:\Users\tanay\Downloads\Database.xlsx");
      excelFile = fullfile(folder, filename);

      writecell(tableData, excelFile, 'Sheet', value);
      uiconfirm(app.UIFigure, 'Table data exported to Excel file.', 'Success', 'Icon', 'success');

      % end
      % Specify the Excel file name
   
        end

        % Button pushed function: ClearRowButton
        function ClearRowButtonPushed(app, event)
        
    % Get the current data in the table
    tableData = app.UITable2.Data;
    
    % Check if the table has any data
    if  ~isequal(tableData(end, :), {'CPF no.','Project number' , 'Name of the project' , 'Tender Type' , 'Approx Project Cost (INR)' , 'PR No.', 'Milestone', 'Plan Date', 'Actual Date'} )
        % Delete the last row
        tableData(end, :) = [];
        
        % Update the table with the modified data
        app.UITable2.Data = tableData;
    else
        % Display a message if the table is empty
        uialert(app.UIFigure, 'The table is already empty.', 'Warning');
    end
        end

        % Value changed function: MonthListBox
        function MonthListBoxValueChanged(app, event)
            value = app.MonthListBox.Value;
            switch(value)
                case 'Select Month'
                    app.ProjectnumberEditFieldLabel.Visible = 'off';
                    app.ProjectnumberEditField.Visible = 'off';
                    app.NameoftheProjectTextArea.Visible = 'off';
                    app.NameoftheProjectTextAreaLabel.Visible = 'off';
                    app.CPFofCoordinatorEditField.Visible ="off";
                    app.CPFofCoordinatorEditFieldLabel.Visible ="off";
                    app.TenderTypeTextArea.Visible= 'off';
                    app.TenderTypeTextAreaLabel.Visible= 'off';
                    app.ApproxProjectCostINREditFieldLabel.Visible = 'off';
                    app.ApproxProjectCostINREditField.Visible = 'off';
                    app.MilestoneEditFieldLabel.Visible = 'off';
                    app.MilestoneEditField.Visible = 'off';
                    app.PRNOEditField.Visible='off';
                    app.PRNOEditFieldLabel.Visible='off';
                    app.PlanDateDatePicker.Visible= 'off';
                    app.PlanDateDatePickerLabel.Visible= 'off';
                    app.ActualDateDatePicker.Visible= 'off';
                    app.ActualDateDatePickerLabel.Visible= 'off';
                    app.FeedButton.Visible = 'off';



                otherwise
                    app.ProjectnumberEditFieldLabel.Visible = 'on';
                    app.ProjectnumberEditField.Visible = 'on';
                    app.NameoftheProjectTextArea.Visible = 'on';
                    app.NameoftheProjectTextAreaLabel.Visible = 'on';
                    app.CPFofCoordinatorEditField.Visible ='on';
                    app.CPFofCoordinatorEditFieldLabel.Visible ='on';
                    app.TenderTypeTextArea.Visible= 'on';
                    app.TenderTypeTextAreaLabel.Visible= 'on';
                    app.ApproxProjectCostINREditFieldLabel.Visible = 'on';
                    app.ApproxProjectCostINREditField.Visible = 'on';
                    app.MilestoneEditFieldLabel.Visible = 'on';
                    app.MilestoneEditField.Visible = 'on';
                    app.PRNOEditField.Visible='on';
                    app.PRNOEditFieldLabel.Visible='on';
                    app.PlanDateDatePicker.Visible= 'on';
                    app.PlanDateDatePickerLabel.Visible= 'on';
                    app.ActualDateDatePicker.Visible= 'on';
                    app.ActualDateDatePickerLabel.Visible= 'on';
                    app.FeedButton.Visible = 'on';



                   
                    app.ProjectnumberEditField.Value = '';
                    app.NameoftheProjectTextArea.Value = '';
                    app.CPFofCoordinatorEditField.Value = '';
                    app.TenderTypeTextArea.Value = '';
                    app.ApproxProjectCostINREditField.Value = '';
                    app.MilestoneEditField.Value = '';
                    app.PRNOEditField.Value = '';
                    app.UITable2.Data='';
                    newRow1 = {'CPF no.','Project number' , 'Name of the project' , 'Tender Type' , 'Approx Project Cost (INR)' , 'PR No.', 'Milestone', 'Plan Date', 'Actual Date'};
                    app.UITable2.Data = [app.UITable2.Data; newRow1];

            end
        end

        % Button pushed function: LoginButton
        function LoginButtonPushed(app, event)
            % app.EnterProjectDetailsButton.Visible= 'on';
            % app.MemberModificationButton.Visible= 'on';
            % app.LoginButton.Visible= 'off';
            % app.CPFNoEditField.Visible = 'off';
            % app.CPFNoEditFieldLabel.Visible = 'off';
            % app.GotoLoginPageButton.Visible = 'on';

            value = app.CPFNoEditField.Value;
            item = value;

            if any(strcmp(app.ListBox2.Items, item))
                app.EnterProjectDetailsButton.Visible= 'on';
                app.MemberModificationButton.Visible= 'on';
                app.LoginButton.Visible= 'off';
                app.CPFNoEditField.Visible = 'off';
                app.CPFNoEditFieldLabel.Visible = 'off';
                app.GotoLoginPageButton.Visible = 'on';


            else
                uiconfirm(app.UIFigure, 'This CPF number does not exist','Access Denied', 'Icon', 'error');
            end

           
        end

        % Button pushed function: EnterProjectDetailsButton
        function EnterProjectDetailsButtonPushed(app, event)
            app.UITable.Visible='on';
            app.BackButton.Visible='on';
            app.CPFofEmployeeEditField.Visible='off';
            app.CPFofEmployeeEditFieldLabel.Visible='off';
            app.AddEmployeeButton.Visible='off';
            app.DeleteEmployeeButton.Visible='off';
            % app.ListBox2.Visible='on';
            app.EnterProjectDetailsButton.Visible='off';
            app.MemberModificationButton.Visible = 'off';

            app.CPFNoEditField.Visible='off';
            app.CPFNoEditFieldLabel.Visible='off';
            app.LoginButton.Visible='off';
            app.GotoLoginPageButton.Visible = 'off';
            value = app.CPFNoEditField.Value;

            switch (value)
                case ('137228')
                    app.ListBox2.Visible='on';
                otherwise
                    app.YourCPFLabel.Visible= "on";
                    app.YourCPFEditField.Visible= "on";
                    app.YourCPFEditField.Value = app.CPFNoEditField.Value;
                    app.ListBox2.Value=app.YourCPFEditField.Value;
                    app.MonthListBox.Visible='on';
            end

        end

        % Button pushed function: MemberModificationButton
        function MemberModificationButtonPushed(app, event)
            value = app.CPFNoEditField.Value;
            switch (value)
                case ('137228')
                    app.CPFofEmployeeEditField.Visible='on';
                    app.CPFofEmployeeEditFieldLabel.Visible='on';
                    app.AddEmployeeButton.Visible='on';
                    app.DeleteEmployeeButton.Visible='on';
                otherwise 
                    % uialert(app.UIFigure, 'You do not have permission to modify this member.', 'Access Denied', 'Icon', 'stop', 'ButtonNames', {'OK'});
                    uiconfirm(app.UIFigure, 'You do not have permission to modify employees','Access Denied', 'Icon', 'error');
            end     
        end

        % Button pushed function: BackButton
        function BackButtonPushed(app, event)
            app.EnterProjectDetailsButton.Visible= 'on';
            app.MemberModificationButton.Visible= 'on';
            app.BackButton.Visible='off';
            app.UITable.Visible="off";
            app.UITable2.Visible="off";
            app.ClearRowButton.Visible= 'off';
            app.SavetoExcelButton.Visible='off';
            app.ListBox2.Visible='off';
            app.ProjectnumberEditFieldLabel.Visible = 'off';
            app.ProjectnumberEditField.Visible = 'off';
            app.NameoftheProjectTextArea.Visible = 'off';
            app.NameoftheProjectTextAreaLabel.Visible = 'off';
            app.CPFofCoordinatorEditField.Visible ="off";
            app.CPFofCoordinatorEditFieldLabel.Visible ="off";
            app.TenderTypeTextArea.Visible= 'off';
            app.TenderTypeTextAreaLabel.Visible= 'off';
            app.ApproxProjectCostINREditFieldLabel.Visible = 'off';
            app.ApproxProjectCostINREditField.Visible = 'off';
            app.MilestoneEditFieldLabel.Visible = 'off';
            app.MilestoneEditField.Visible = 'off';
            app.PRNOEditField.Visible='off';
            app.PRNOEditFieldLabel.Visible='off';
            app.PlanDateDatePicker.Visible= 'off';
            app.PlanDateDatePickerLabel.Visible= 'off';
            app.ActualDateDatePicker.Visible= 'off';
            app.ActualDateDatePickerLabel.Visible= 'off';
            app.FeedButton.Visible = 'off';
            app.MonthListBox.Visible='off';
            app.YourCPFEditField.Visible='off';
            app.YourCPFLabel.Visible = 'off';
            app.MonthListBoxLabel.Visible='off';

            app.GotoLoginPageButton.Visible = 'on';
          

        end

        % Button pushed function: AddEmployeeButton
        function AddEmployeeButtonPushed(app, event)
            value = app.CPFofEmployeeEditField.Value;
            app.ListBox2.Items{end+1} = value;
            uiconfirm(app.UIFigure, ' Employee Successfully Added', 'Success', 'Icon', 'success');
        end

        % Button pushed function: GotoLoginPageButton
        function GotoLoginPageButtonPushed(app, event)
            app.CPFNoEditField.Visible = 'on';
            app.CPFNoEditFieldLabel.Visible = 'on';
            app.LoginButton.Visible = 'on';
            app.GotoLoginPageButton.Visible = 'off';
            app.MemberModificationButton.Visible= 'off';
            app.EnterProjectDetailsButton.Visible = 'off';
            app.CPFofEmployeeEditField.Visible = 'off';
            app.CPFofEmployeeEditFieldLabel.Visible = 'off';
            app.AddEmployeeButton.Visible = 'off';
            app.DeleteEmployeeButton.Visible = 'off';
            app.BackButton.Visible = 'off';
        end

        % Button pushed function: DeleteEmployeeButton
        function DeleteEmployeeButtonPushed(app, event)
            value=app.CPFofEmployeeEditField.Value;
            item = value;

            if any(strcmp(app.ListBox2.Items, item))
                itemToDelete = value; % Value of the item to delete
                currentItems = app.ListBox2.Items;
                newItems = currentItems;
                newItems(strcmp(newItems, itemToDelete)) = [];
                app.ListBox2.Items = newItems;
                uiconfirm(app.UIFigure, ' Employee Successfully deleted', 'Success', 'Icon', 'success');

            else
                uiconfirm(app.UIFigure, 'This CPF number does not exist','Access Denied', 'Icon', 'error');
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 2001 1804];
            app.UIFigure.Name = 'MATLAB App';

            % Create Image
            app.Image = uiimage(app.UIFigure);
            app.Image.Position = [545 1407 85 83];
            app.Image.ImageSource = 'logoongc.jpeg';

            % Create COMMUNICATIONGROUPINFOCOMLabel
            app.COMMUNICATIONGROUPINFOCOMLabel = uilabel(app.UIFigure);
            app.COMMUNICATIONGROUPINFOCOMLabel.FontSize = 18;
            app.COMMUNICATIONGROUPINFOCOMLabel.FontWeight = 'bold';
            app.COMMUNICATIONGROUPINFOCOMLabel.Position = [425 1357 325 52];
            app.COMMUNICATIONGROUPINFOCOMLabel.Text = 'COMMUNICATION GROUP INFOCOM';

            % Create UITable
            app.UITable = uitable(app.UIFigure);
            app.UITable.ColumnName = {'Sr. No'; 'Name'; 'Designation'; 'Level'; 'CPF no.'; 'Telephone no.'; 'Mobile no.'; 'Seat'; 'email id'};
            app.UITable.RowName = {};
            app.UITable.ColumnEditable = [true true true true true false false];
            app.UITable.Visible = 'off';
            app.UITable.Position = [66 1047 532 280];

            % Create ApproxProjectCostINREditFieldLabel
            app.ApproxProjectCostINREditFieldLabel = uilabel(app.UIFigure);
            app.ApproxProjectCostINREditFieldLabel.HorizontalAlignment = 'right';
            app.ApproxProjectCostINREditFieldLabel.Visible = 'off';
            app.ApproxProjectCostINREditFieldLabel.Position = [11 745 140 22];
            app.ApproxProjectCostINREditFieldLabel.Text = 'Approx Project Cost(INR)';

            % Create ApproxProjectCostINREditField
            app.ApproxProjectCostINREditField = uieditfield(app.UIFigure, 'text');
            app.ApproxProjectCostINREditField.InputType = 'alphanumerics';
            app.ApproxProjectCostINREditField.Visible = 'off';
            app.ApproxProjectCostINREditField.Position = [162 734 290 40];

            % Create MilestoneEditFieldLabel
            app.MilestoneEditFieldLabel = uilabel(app.UIFigure);
            app.MilestoneEditFieldLabel.HorizontalAlignment = 'right';
            app.MilestoneEditFieldLabel.Visible = 'off';
            app.MilestoneEditFieldLabel.Position = [511 891 112 22];
            app.MilestoneEditFieldLabel.Text = 'Milestone';

            % Create MilestoneEditField
            app.MilestoneEditField = uieditfield(app.UIFigure, 'text');
            app.MilestoneEditField.Visible = 'off';
            app.MilestoneEditField.Position = [634 882 292 40];

            % Create Hyperlink
            app.Hyperlink = uihyperlink(app.UIFigure);
            app.Hyperlink.Position = [-29 1833 2 2];

            % Create ListBox2
            app.ListBox2 = uilistbox(app.UIFigure);
            app.ListBox2.Items = {'Select CPF no.', '64988', '78538', '81634', '121757', '70876', '135752', '137228', '138461', '124715', '124777', '136694', '141345', '81159'};
            app.ListBox2.ValueChangedFcn = createCallbackFcn(app, @ListBox2ValueChanged, true);
            app.ListBox2.Visible = 'off';
            app.ListBox2.FontSize = 14;
            app.ListBox2.Position = [670 1140 166 185];
            app.ListBox2.Value = 'Select CPF no.';

            % Create FeedButton
            app.FeedButton = uibutton(app.UIFigure, 'push');
            app.FeedButton.ButtonPushedFcn = createCallbackFcn(app, @FeedButtonPushed, true);
            app.FeedButton.Visible = 'off';
            app.FeedButton.Position = [348 686 394 32];
            app.FeedButton.Text = 'Feed';

            % Create ProjectnumberEditFieldLabel
            app.ProjectnumberEditFieldLabel = uilabel(app.UIFigure);
            app.ProjectnumberEditFieldLabel.HorizontalAlignment = 'right';
            app.ProjectnumberEditFieldLabel.Visible = 'off';
            app.ProjectnumberEditFieldLabel.Position = [60 946 86 22];
            app.ProjectnumberEditFieldLabel.Text = 'Project number';

            % Create ProjectnumberEditField
            app.ProjectnumberEditField = uieditfield(app.UIFigure, 'text');
            app.ProjectnumberEditField.InputType = 'digits';
            app.ProjectnumberEditField.Visible = 'off';
            app.ProjectnumberEditField.Position = [161 936 293 43];

            % Create SavetoExcelButton
            app.SavetoExcelButton = uibutton(app.UIFigure, 'push');
            app.SavetoExcelButton.ButtonPushedFcn = createCallbackFcn(app, @SavetoExcelButtonPushed, true);
            app.SavetoExcelButton.Visible = 'off';
            app.SavetoExcelButton.Position = [348 999 256 32];
            app.SavetoExcelButton.Text = 'Save to Excel';

            % Create ActualDateDatePickerLabel
            app.ActualDateDatePickerLabel = uilabel(app.UIFigure);
            app.ActualDateDatePickerLabel.HorizontalAlignment = 'right';
            app.ActualDateDatePickerLabel.Visible = 'off';
            app.ActualDateDatePickerLabel.Position = [558 781 67 22];
            app.ActualDateDatePickerLabel.Text = 'Actual Date';

            % Create ActualDateDatePicker
            app.ActualDateDatePicker = uidatepicker(app.UIFigure);
            app.ActualDateDatePicker.Visible = 'off';
            app.ActualDateDatePicker.Position = [637 772 288 40];

            % Create ClearRowButton
            app.ClearRowButton = uibutton(app.UIFigure, 'push');
            app.ClearRowButton.ButtonPushedFcn = createCallbackFcn(app, @ClearRowButtonPushed, true);
            app.ClearRowButton.Visible = 'off';
            app.ClearRowButton.Position = [67 1001 262 30];
            app.ClearRowButton.Text = 'Clear Row';

            % Create MonthListBoxLabel
            app.MonthListBoxLabel = uilabel(app.UIFigure);
            app.MonthListBoxLabel.HorizontalAlignment = 'right';
            app.MonthListBoxLabel.Visible = 'off';
            app.MonthListBoxLabel.Position = [848 1301 38 22];
            app.MonthListBoxLabel.Text = 'Month';

            % Create MonthListBox
            app.MonthListBox = uilistbox(app.UIFigure);
            app.MonthListBox.Items = {'Select Month', 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'};
            app.MonthListBox.ValueChangedFcn = createCallbackFcn(app, @MonthListBoxValueChanged, true);
            app.MonthListBox.Visible = 'off';
            app.MonthListBox.Position = [901 1141 131 184];
            app.MonthListBox.Value = 'Select Month';

            % Create CPFNoEditFieldLabel
            app.CPFNoEditFieldLabel = uilabel(app.UIFigure);
            app.CPFNoEditFieldLabel.HorizontalAlignment = 'right';
            app.CPFNoEditFieldLabel.Position = [471 1299 51 22];
            app.CPFNoEditFieldLabel.Text = 'CPF No.';

            % Create CPFNoEditField
            app.CPFNoEditField = uieditfield(app.UIFigure, 'text');
            app.CPFNoEditField.InputType = 'digits';
            app.CPFNoEditField.Position = [529 1299 176 32];

            % Create LoginButton
            app.LoginButton = uibutton(app.UIFigure, 'push');
            app.LoginButton.ButtonPushedFcn = createCallbackFcn(app, @LoginButtonPushed, true);
            app.LoginButton.Position = [517 1252 142 24];
            app.LoginButton.Text = 'Login';

            % Create YourCPFLabel
            app.YourCPFLabel = uilabel(app.UIFigure);
            app.YourCPFLabel.HorizontalAlignment = 'right';
            app.YourCPFLabel.Visible = 'off';
            app.YourCPFLabel.Position = [670 1299 57 22];
            app.YourCPFLabel.Text = 'Your CPF';

            % Create YourCPFEditField
            app.YourCPFEditField = uieditfield(app.UIFigure, 'text');
            app.YourCPFEditField.Editable = 'off';
            app.YourCPFEditField.Visible = 'off';
            app.YourCPFEditField.Position = [742 1293 94 32];

            % Create CPFofCoordinatorEditFieldLabel
            app.CPFofCoordinatorEditFieldLabel = uilabel(app.UIFigure);
            app.CPFofCoordinatorEditFieldLabel.HorizontalAlignment = 'right';
            app.CPFofCoordinatorEditFieldLabel.Visible = 'off';
            app.CPFofCoordinatorEditFieldLabel.Position = [47 852 108 22];
            app.CPFofCoordinatorEditFieldLabel.Text = 'CPF of Coordinator';

            % Create CPFofCoordinatorEditField
            app.CPFofCoordinatorEditField = uieditfield(app.UIFigure, 'text');
            app.CPFofCoordinatorEditField.InputType = 'digits';
            app.CPFofCoordinatorEditField.Visible = 'off';
            app.CPFofCoordinatorEditField.Position = [166 838 289 36];

            % Create NameoftheProjectTextAreaLabel
            app.NameoftheProjectTextAreaLabel = uilabel(app.UIFigure);
            app.NameoftheProjectTextAreaLabel.HorizontalAlignment = 'right';
            app.NameoftheProjectTextAreaLabel.Visible = 'off';
            app.NameoftheProjectTextAreaLabel.Position = [40 898 111 22];
            app.NameoftheProjectTextAreaLabel.Text = 'Name of the Project';

            % Create NameoftheProjectTextArea
            app.NameoftheProjectTextArea = uitextarea(app.UIFigure);
            app.NameoftheProjectTextArea.Visible = 'off';
            app.NameoftheProjectTextArea.Position = [166 882 292 40];

            % Create TenderTypeTextAreaLabel
            app.TenderTypeTextAreaLabel = uilabel(app.UIFigure);
            app.TenderTypeTextAreaLabel.HorizontalAlignment = 'right';
            app.TenderTypeTextAreaLabel.Visible = 'off';
            app.TenderTypeTextAreaLabel.Position = [75 802 71 22];
            app.TenderTypeTextAreaLabel.Text = 'Tender Type';

            % Create TenderTypeTextArea
            app.TenderTypeTextArea = uitextarea(app.UIFigure);
            app.TenderTypeTextArea.Visible = 'off';
            app.TenderTypeTextArea.Position = [161 784 292 42];

            % Create PRNOEditFieldLabel
            app.PRNOEditFieldLabel = uilabel(app.UIFigure);
            app.PRNOEditFieldLabel.HorizontalAlignment = 'right';
            app.PRNOEditFieldLabel.Visible = 'off';
            app.PRNOEditFieldLabel.Position = [581 957 46 22];
            app.PRNOEditFieldLabel.Text = 'PR NO.';

            % Create PRNOEditField
            app.PRNOEditField = uieditfield(app.UIFigure, 'text');
            app.PRNOEditField.InputType = 'digits';
            app.PRNOEditField.Visible = 'off';
            app.PRNOEditField.Position = [638 936 289 43];

            % Create PlanDateDatePickerLabel
            app.PlanDateDatePickerLabel = uilabel(app.UIFigure);
            app.PlanDateDatePickerLabel.HorizontalAlignment = 'right';
            app.PlanDateDatePickerLabel.Visible = 'off';
            app.PlanDateDatePickerLabel.Position = [567 834 58 22];
            app.PlanDateDatePickerLabel.Text = 'Plan Date';

            % Create PlanDateDatePicker
            app.PlanDateDatePicker = uidatepicker(app.UIFigure);
            app.PlanDateDatePicker.Visible = 'off';
            app.PlanDateDatePicker.Position = [637 825 288 40];

            % Create EnterProjectDetailsButton
            app.EnterProjectDetailsButton = uibutton(app.UIFigure, 'push');
            app.EnterProjectDetailsButton.ButtonPushedFcn = createCallbackFcn(app, @EnterProjectDetailsButtonPushed, true);
            app.EnterProjectDetailsButton.Visible = 'off';
            app.EnterProjectDetailsButton.Position = [311 1299 262 32];
            app.EnterProjectDetailsButton.Text = 'Enter Project Details';

            % Create MemberModificationButton
            app.MemberModificationButton = uibutton(app.UIFigure, 'push');
            app.MemberModificationButton.ButtonPushedFcn = createCallbackFcn(app, @MemberModificationButtonPushed, true);
            app.MemberModificationButton.Visible = 'off';
            app.MemberModificationButton.Position = [602 1299 256 32];
            app.MemberModificationButton.Text = 'Member Modification';

            % Create CPFofEmployeeEditFieldLabel
            app.CPFofEmployeeEditFieldLabel = uilabel(app.UIFigure);
            app.CPFofEmployeeEditFieldLabel.HorizontalAlignment = 'right';
            app.CPFofEmployeeEditFieldLabel.Visible = 'off';
            app.CPFofEmployeeEditFieldLabel.Position = [388 1222 99 22];
            app.CPFofEmployeeEditFieldLabel.Text = 'CPF of Employee';

            % Create CPFofEmployeeEditField
            app.CPFofEmployeeEditField = uieditfield(app.UIFigure, 'text');
            app.CPFofEmployeeEditField.Visible = 'off';
            app.CPFofEmployeeEditField.Position = [502 1222 260 22];

            % Create AddEmployeeButton
            app.AddEmployeeButton = uibutton(app.UIFigure, 'push');
            app.AddEmployeeButton.ButtonPushedFcn = createCallbackFcn(app, @AddEmployeeButtonPushed, true);
            app.AddEmployeeButton.Visible = 'off';
            app.AddEmployeeButton.Position = [316 1176 259 29];
            app.AddEmployeeButton.Text = 'Add Employee';

            % Create DeleteEmployeeButton
            app.DeleteEmployeeButton = uibutton(app.UIFigure, 'push');
            app.DeleteEmployeeButton.ButtonPushedFcn = createCallbackFcn(app, @DeleteEmployeeButtonPushed, true);
            app.DeleteEmployeeButton.Visible = 'off';
            app.DeleteEmployeeButton.Position = [596 1176 259 29];
            app.DeleteEmployeeButton.Text = 'Delete Employee';

            % Create BackButton
            app.BackButton = uibutton(app.UIFigure, 'push');
            app.BackButton.ButtonPushedFcn = createCallbackFcn(app, @BackButtonPushed, true);
            app.BackButton.Visible = 'off';
            app.BackButton.Position = [161 688 138 30];
            app.BackButton.Text = 'Back';

            % Create GotoLoginPageButton
            app.GotoLoginPageButton = uibutton(app.UIFigure, 'push');
            app.GotoLoginPageButton.ButtonPushedFcn = createCallbackFcn(app, @GotoLoginPageButtonPushed, true);
            app.GotoLoginPageButton.Visible = 'off';
            app.GotoLoginPageButton.Position = [480 1101 191 27];
            app.GotoLoginPageButton.Text = 'Go to Login Page';

            % Create UITable2
            app.UITable2 = uitable(app.UIFigure);
            app.UITable2.ColumnName = '';
            app.UITable2.RowName = {};
            app.UITable2.Visible = 'off';
            app.UITable2.Position = [70 1041 527 280];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = prototype_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end