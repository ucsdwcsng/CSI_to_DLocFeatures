function MP=compute_2D_multipath_profile(h,theta_vals,d_vals,opt)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Convert CSI channels to AoA-ToF Images
% Inputs
% h                  : [n_sub, n_rx] MATRIX CSI data
% theta_vals         : [1, n_thetas] Vector of AoA search space in radians
% d_vals             : [1, n_distances] Vector of Distance search space in
%                      meters
% opt (struct)       : stuct that contains constants like 
%                      freq, bandwidth, etc.
% Returns:
% MP                 : [n_thetas, n_distances] MATRIX AoA-ToF Multipath
%                      Profile 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

freq_cent = median(opt.freq);
const = 1j*2*pi/(3e8);
const2 = 1j*2*pi*opt.ant_sep*freq_cent/(3e8);

h = h.';
d_rep = const*(opt.freq'.*repmat(d_vals,length(opt.freq),1));
temp = h*exp(d_rep);

theta_rep = const2*((1:size(h,1)).*repmat(sin(theta_vals'),1,size(h,1)));

MP = exp(theta_rep)*(temp);
MP = abs(MP)./abs(MP(:));
        
end