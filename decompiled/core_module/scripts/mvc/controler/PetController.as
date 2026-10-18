package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import flash.utils.Dictionary;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.PetComposeGoodsTemplete;
   import yishi.manager.TempleteManager;
   
   public class PetController extends FrameController
   {
      
      public static const PET_FRAME:String = "PET_FRAME";
      
      public static const LOOKUP_FRAME:String = "LOOKUP_FRAME";
      
      private var _petCompose100CostPoint:int = 0;
      
      private var _composePetTemplateList:Vector.<PetComposeGoodsTemplete>;
      
      private var _mixPetTemplateList:Vector.<PetComposeGoodsTemplete>;
      
      public function PetController()
      {
         super();
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == "PET_FRAME")
         {
            return "pet.PetFrame";
         }
         if(_data.openType == "LOOKUP_FRAME")
         {
            return "pet.lookup.PetLookUpView";
         }
         return "pet.PetFrame";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"](_data);
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      public function get isOpenedFrame() : Boolean
      {
         return _frame != null && frameClassName == "pet.PetFrame";
      }
      
      public function set petCompose100CostPoint(param1:int) : void
      {
         _petCompose100CostPoint = param1;
      }
      
      public function get petCompose100CostPoint() : int
      {
         var _loc1_:ConfigInfosTempInfo = null;
         if(_petCompose100CostPoint == 0)
         {
            _petCompose100CostPoint = 200;
            _loc1_ = TempleteManager.instance.getConfigInfoByConfigName("fuse_pet_points");
            if(_loc1_)
            {
               _petCompose100CostPoint = parseInt(_loc1_.ConfigValue);
            }
         }
         return _petCompose100CostPoint;
      }
      
      public function getComposePetTemplateList() : Vector.<PetComposeGoodsTemplete>
      {
         var _loc1_:Dictionary = null;
         if(!_composePetTemplateList)
         {
            _composePetTemplateList = new Vector.<PetComposeGoodsTemplete>();
            _loc1_ = TempleteManager.instance.getPetComposeTempleteList();
            for each(var _loc2_:PetComposeGoodsTemplete in _loc1_)
            {
               _composePetTemplateList.push(_loc2_);
            }
         }
         return _composePetTemplateList;
      }
      
      public function getMixPetTemplateList() : Vector.<PetComposeGoodsTemplete>
      {
         var _loc1_:Dictionary = null;
         if(!_mixPetTemplateList)
         {
            _mixPetTemplateList = new Vector.<PetComposeGoodsTemplete>();
            _loc1_ = TempleteManager.instance.getPetComposeTempleteList();
            for each(var _loc2_:PetComposeGoodsTemplete in _loc1_)
            {
               if(_loc2_.Pet2Types != 0)
               {
                  _mixPetTemplateList.push(_loc2_);
               }
            }
         }
         return _mixPetTemplateList;
      }
   }
}

