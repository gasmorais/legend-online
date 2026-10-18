package consortiachess.board
{
   import consortiachess.util.ChesspvpConst;
   
   public class ConsortiaChessKing extends ConsortiaChessBasePiece
   {
      
      public function ConsortiaChessKing(param1:ConsortiaChessBoard)
      {
         super(param1);
      }
      
      override protected function updateDirectionPaths() : void
      {
         super.updateDirectionPaths();
         var _loc2_:Array = ChesspvpConst.KING_RULES;
         for each(var _loc1_:Object in _loc2_)
         {
            _directPathDic[_loc1_] = getLines(_loc1_,1);
         }
      }
   }
}

