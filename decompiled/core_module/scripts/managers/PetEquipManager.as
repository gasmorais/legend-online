package managers
{
   import mvc.module.pet.PetData;
   import yishi.datas.goods.GoodsInfo;
   
   public class PetEquipManager
   {
      
      private static var _instance:PetEquipManager;
      
      public static var currSelectedPetData:PetData;
      
      public static var currSelectedPage:String;
      
      public static var currSelectedView:String;
      
      public static var currGodHeadItem:GoodsInfo;
      
      public static var refineryUseBind:Boolean;
      
      public static var isFirstClick:Boolean = true;
      
      public function PetEquipManager()
      {
         super();
      }
      
      public static function get instance() : PetEquipManager
      {
         if(!_instance)
         {
            _instance = new PetEquipManager();
         }
         return _instance;
      }
   }
}

