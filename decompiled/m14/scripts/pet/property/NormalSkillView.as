package pet.property
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.pet.PetData;
   
   public class NormalSkillView extends Component
   {
      
      private var _titleBg:Bitmap;
      
      private var _title:GradientText;
      
      private var _skillA:PetNormalSkillItemView;
      
      private var _skillB:PetNormalSkillItemView;
      
      private var _skillC:PetNormalSkillItemView;
      
      private var _itemList:Array;
      
      private var _data:PetData;
      
      public function NormalSkillView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _titleBg = ComponentFactory.Instance.creatBitmap("asset.pet.MorphSKillBg");
         _titleBg.x = (166 - _titleBg.width) / 2;
         _titleBg.y = -13;
         _title = ComponentFactory.Instance.creatComponentByStylename("NormalSkillView.MorphSkillText");
         _title.text = LanguageMgr.GetTranslation("NormalSkillView.title");
         _title.x = (166 - _title.textWidth) / 2;
         addChild(_titleBg);
         addChild(_title);
         _skillA = new PetNormalSkillItemView();
         _skillB = new PetNormalSkillItemView();
         _skillC = new PetNormalSkillItemView();
         _skillA.x = -12;
         _skillB.x = 69;
         _skillC.x = 153;
         _skillA.y = _skillB.y = _skillC.y = 5;
         addChild(_skillA);
         addChild(_skillB);
         addChild(_skillC);
         _itemList = [_skillA,_skillB,_skillC];
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_skillA);
         _skillA = null;
         ObjectUtils.disposeObject(_skillB);
         _skillB = null;
         ObjectUtils.disposeObject(_skillC);
         _skillC = null;
         _itemList = null;
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function get data() : PetData
      {
         return _data;
      }
      
      public function set data(param1:PetData) : void
      {
         _data = param1;
         if(_data)
         {
            refresh();
         }
         else
         {
            restore();
         }
      }
      
      private function refresh() : void
      {
         var _loc3_:int = 0;
         var _loc2_:PetNormalSkillItemView = null;
         var _loc1_:Array = _data.followSkillTemplates;
         _loc3_ = 0;
         while(_loc3_ < _itemList.length)
         {
            _loc2_ = _itemList[_loc3_];
            _loc2_.data = _loc1_[_loc3_];
            _loc3_++;
         }
      }
      
      private function restore() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PetNormalSkillItemView = null;
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _loc1_ = _itemList[_loc2_];
            _loc1_.data = null;
            _loc2_++;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
         _data = null;
      }
   }
}

