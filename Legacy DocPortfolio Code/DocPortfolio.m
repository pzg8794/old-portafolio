classdef DocPortfolio 
    properties
        Name = '';
    end
    properties (SetAccess = private) 
        IndAssets = {};
        TotalValue = 0;
    end
        
    methods
        function p = DocPortfolio(name,varargin)
        % Create a DocPortfolio object containing the 
        % client's name and a list of asset objects
            p.Name = name;
            for k = 1:length(varargin) % Store objects in a cell array
                p.IndAssets{k} = {varargin{k}};
                asset_value = p.IndAssets{k}{1}.CurrentValue;
                p.TotalValue = p.TotalValue + asset_value;
            end
        end % DocPortfolio
        
        function disp(p)
        % DISPLAY Display a DocPortfolio object
             fprintf('\nAssets for Client: %s\n',p.Name);
            for k = 1:length(p.IndAssets)
                disp(p.IndAssets{k}{1})
            end
            fprintf('\nTotal Value: $%0.2f\n',p.TotalValue);
        end % disp
        
        function pie3(p)
        % PIE3 Creates a pie chart of an individual's
        % finacial DocPortfolio as represented by a DocPortfolio object
            stock_amt = 0; bond_amt = 0; savings_amt = 0;
            for k=1:length(p.IndAssets)               
               if isa(p.IndAssets{k}{1},'DocStock')
                    stock_amt = stock_amt + p.IndAssets{k}{1}.CurrentValue;
               elseif isa(p.IndAssets{k}{1},'DocBond')
                   bond_amt = bond_amt + p.IndAssets{k}{1}.CurrentValue;
               elseif isa(p.IndAssets{k}{1},'DocSavings')
                  savings_amt = savings_amt + p.IndAssets{k}{1}.CurrentValue;
                end
            end
            i = 1;
            if stock_amt ~= 0
                label(i) = {'Stocks'};
                pie_vector(i) = stock_amt;
                i = i +1;
            end
            if bond_amt ~= 0
                label(i) = {'Bonds'};
                pie_vector(i) = bond_amt;
                i = i +1;
            end
            if savings_amt ~= 0
                label(i) = {'Savings'};
                pie_vector(i) = savings_amt;
            end
            pie3(pie_vector,label)
            set(findobj(gca,'Type','Text'),'FontSize',14,'FontWeight','bold') 
            set(gcf,'Renderer','zbuffer')
            colormap prism
            stg(1) = {['Portfolio Composition for ',p.Name]};
            stg(2) = {['Total Value of Assets: $',num2str(p.TotalValue,'%0.2f')]};
            title(stg,'FontSize',10) 
        end % pie3
    end
end % DocPortfilio class
