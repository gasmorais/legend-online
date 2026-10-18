package mvc.module.poseidon
{
   import yishi.utils.SimpleDictionary;
   
   public class PoseidonModel
   {
      
      private var _buyDic:SimpleDictionary;
      
      public function PoseidonModel()
      {
         super();
         _buyDic = new SimpleDictionary();
      }
      
      public function addGoodInfo(param1:int, param2:PoseidonGoodInfo) : void
      {
         _buyDic.add(param1,param2);
      }
      
      public function getGoodInfo(param1:int) : PoseidonGoodInfo
      {
         return _buyDic[param1];
      }
   }
}

