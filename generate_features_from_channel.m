function features = generate_features_from_channel(channels,ap,theta_vals,d_vals,d1,d2,ap_index,opt)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Convert CSI "channels" to image for training.
% INPUTS
% channels       :[n_sub, n_rx, n_ap] MATRIX csi channel data if ap_index=3
%                            or
%                :[n_sub, n_ap, n_rx] MATRIX csi channel data if ap_index=2
% ap       (cell): xy coordinates of APs. Each cell is n_rx, 2] matrix
% theta_vals     : [1, n_thetas] vector of AoA search space in radians. 
% d_vals         : [1, n_distances] Vector of Distance search space in
%                  meters
% d1             : [1, x_values] Vector of X-axis values of image.
% d2             : [1, y_values] Vector of Y-axis values of image.
% ap_index       : Scalar value (2 or 3) indicating the dimension of the
%                  channel matrix that has AP indeices
% opt (struct)   : stuct that contains constants like 
%        freq, bandwidth, etc.
%
% OUTPUT
% feature        : [n_ap, x_values, y_values] MATRIX n_ap XY feature images
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
n_ap=length(ap);

features = zeros(n_ap,length(d2),length(d1));
for j=1:n_ap
    if ap_index==3
        P = compute_2D_multipath_profile(squeeze(channels(:,:,j)),theta_vals,d_vals,opt);
    elseif ap_index==2
        P = compute_2D_multipath_profile(squeeze(channels(:,j,:)),theta_vals,d_vals,opt);
    end
    P_out = convert_multipathProfile_to_xy(P,theta_vals,d_vals,d1,d2,ap{j});
    features(j,:,:) = abs(P_out)./abs(P_out(:));
end

end
