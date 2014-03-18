
function [ C_out ] = FLA_Gemm_nt_blk_var4( alpha, A, B, C, nb_alg )

  [ BT, ...
    BB ] = FLA_Part_2x1( B, ...
                         0, 'FLA_BOTTOM' );

  [ CL, CR ] = FLA_Part_1x2( C, ...
                               0, 'FLA_RIGHT' );

  while ( size( BB, 1 ) < size( B, 1 ) )

    b = min( size( BT, 1 ), nb_alg );

    [ B0, ...
      B1, ...
      B2 ] = FLA_Repart_2x1_to_3x1( BT, ...
                                    BB, ...
                                    b, 'FLA_TOP' );

    [ C0, C1, C2 ]= FLA_Repart_1x2_to_1x3( CL, CR, ...
                                         b, 'FLA_LEFT' );

    %------------------------------------------------------------%

    C1 = alpha * A * B1' + C1;

    %------------------------------------------------------------%

    [ BT, ...
      BB ] = FLA_Cont_with_3x1_to_2x1( B0, ...
                                       B1, ...
                                       B2, ...
                                       'FLA_BOTTOM' );

    [ CL, CR ] = FLA_Cont_with_1x3_to_1x2( C0, C1, C2, ...
                                           'FLA_RIGHT' );

  end

  C_out = [ CL, CR ];

return

