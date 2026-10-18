package consortiachess.board
{
   import consortiachess.util.ChesspvpConst;
   
   public class ConsortiaChessKnight extends ConsortiaChessBasePiece
   {
      
      public function ConsortiaChessKnight(param1:ConsortiaChessBoard)
      {
         super(param1);
      }
      
      override protected function updateDirectionPaths() : void
      {
         super.updateDirectionPaths();
         var _loc2_:Array = ChesspvpConst.KNIGHT_RULES;
         for each(var _loc1_:Object in _loc2_)
         {
            _directPathDic[_loc1_] = getLines(_loc1_,1);
         }
      }
   }
}

