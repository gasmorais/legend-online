package consortiachess.board
{
   import consortiachess.util.ChesspvpConst;
   
   public class ConsortiaChessQueen extends ConsortiaChessBasePiece
   {
      
      public function ConsortiaChessQueen(param1:ConsortiaChessBoard)
      {
         super(param1);
      }
      
      override protected function updateDirectionPaths() : void
      {
         super.updateDirectionPaths();
         var _loc2_:Array = ChesspvpConst.QUEEN_RULES;
         for each(var _loc1_:Object in _loc2_)
         {
            _directPathDic[_loc1_] = getLines(_loc1_);
         }
      }
   }
}

