function [ uMax ] = eppGrowMax( Temperature , Method)
%EPPGROWMAX calculates the maximum phytoplankton growth rate at specified
%   temperature(s) according to the Eppley growth curve from
%
% INPUTS:
%   1) Temperature - specifies temperature(s) at which to calculate the
%       maximum growth rate.  Can be scalar or vector.  If vector, it is
%       calculated at each temperature value, or treated according to
%       Method (input argument #2), if specified.
%
%   2) Method - (Default is 'each')
%       Specifies how to treat temperature vector input.  Currently
%       there are two options: 'each' or 'mean'.  If method is 'each', then
%       function will calculate uMax for each element of Temperature input
%       and uMax output will have number of elements equal to Temperature.
%       If method is 'mean', then function will average together each
%       successive pair in Temperature & calculate uMax for each averaged
%       Temperature, and uMax output will have number of elements equal to
%       length(Temperature-1).  Method input will be ignored if Temperature
%       input is scalar.  Method accepts partial strings, such as 'mea',
%       'm','ea' or 'e'.
%
%   Example:
%       temps = 1:40;
%       plot( temps, eppGrowMax(temps) );
%
%
%  REFERENCE: 
%   Eppley, R. W. 1972. Temperature and phytoplankton growth in the sea.
%       Fish. Bull. 70: 1063-1085. 
%
%  MFILE:   eppGrowMax.m
%  MATLAB:  8.5.0.197613 (R2015a)
%  AUTHOR:  Daniel Edward Kaufman (USA), @ The Virginia Institute of Marine Science
%  CONTACT: dkauf42@gmail.com
%
%  REVISIONS:
%   - Initial Generation. (Aug, 2013)
%   - Updated input parsing and description. (Apr, 2015)

%% Initial Function Housekeeping, parse input arguments
narginchk(1, 2);
if ~isvector(Temperature) || ~isscalar(Temperature);
    error('Expected input number 1, Temperature, to be a numeric scalar or vector');
end;
methodName = 'each'; % Default
if nargin == 2
    validStrings = {'Means','Each'};
    methodName = validatestring(Method,validStrings,mfilename,'Method',2);
end

%% MAIN
% Eppley Max Growth Rates by Temperature
if length(Temperature) == 1
    uMax = 0.59 * exp(0.0633 * Temperature );
elseif length(Temperature) > 1
    switch lower(methodName)
        case 'means'
            uMax = 0.59 .* exp(0.0633 .* nanmean( [Temperature(2:end);Temperature(1:end-1)] ) );
        case 'each'
            uMax = 0.59 .* exp(0.0633 .* Temperature );
        otherwise
            error('Bad Switch Case')
    end
end

end