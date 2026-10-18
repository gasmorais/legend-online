package pet.property
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import manager.LanguageMgr;
   import managers.PetSocketOut;
   import mvc.module.pet.PetData;
   import pet.learnskill.PetSkillItemViewII;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.view.component.TileContainer;
   
   public class MorphingSkillView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _titleBg:Bitmap;
      
      private var _title:GradientText;
      
      private var _box:TileContainer;
      
      private var _itemList:Array;
      
      private var _lockBg:DisplayObject;
      
      private var _skillEnable:Boolean;
      
      private var _data:PetData;
      
      public function MorphingSkillView(param1:Boolean = true)
      {
         super();
         _skillEnable = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PetSkillItemViewII = null;
         _lockBg = ComponentFactory.Instance.creat("asset.pet.Open55");
         _bg = ComponentFactory.Instance.creatBitmap("asset.pet.skillBG_open");
         _titleBg = ComponentFactory.Instance.creatBitmap("asset.pet.MorphSKillBg");
         _title = ComponentFactory.Instance.creatComponentByStylename("pet.MorphSkillText");
         _box = ComponentFactory.Instance.creatCustomObject("pet.TileContainer");
         _itemList = [];
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new PetSkillItemViewII();
            _loc1_.skillEnable = _skillEnable;
            _box.appendItem(_loc1_);
            if(_loc2_ >= 5)
            {
               _loc1_.skillType = 2;
            }
            else
            {
               _loc1_.skillType = 1;
               _loc1_.index = _loc2_;
            }
            _itemList.push(_loc1_);
            _loc2_++;
         }
         _title.text = LanguageMgr.GetTranslation("pet.PetFrame.morphSkill");
         addChild(_bg);
         addChild(_titleBg);
         addChild(_title);
         addChild(_box);
         addChild(_lockBg);
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_box);
         _box = null;
         _itemList = null;
         ObjectUtils.disposeObject(_lockBg);
         _lockBg = null;
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("PET_SKILL_CHANGE",__setFastKeyHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("PET_SKILL_CHANGE",__setFastKeyHandler);
      }
      
      private function __setFastKeyHandler(param1:NotificationEvent) : void
      {
         PetSocketOut.setSkillFastKey(_data.petId,fastKey);
      }
      
      public function get fastKey() : String
      {
         var _loc3_:int = 0;
         var _loc2_:PetSkillItemViewII = null;
         var _loc1_:String = "";
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc2_ = _itemList[_loc3_] as PetSkillItemViewII;
            if(_loc2_.data)
            {
               _loc1_ += _loc2_.data.SonType + ",";
            }
            else
            {
               _loc1_ += "-1,";
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function get data() : PetData
      {
         return _data;
      }
      
      public function set data(param1:PetData) : void
      {
         _data = param1;
         restore();
         if(_data)
         {
            refresh();
         }
         showView();
      }
      
      private function restore() : void
      {
         for each(var _loc1_:PetSkillItemViewII in _itemList)
         {
            _loc1_.data = null;
         }
      }
      
      private function refresh() : void
      {
         var _loc1_:PetSkillItemViewII = null;
         var _loc2_:SkillTempInfo = null;
         for each(_loc1_ in _itemList)
         {
            _loc1_.data = null;
         }
         if(!_data)
         {
            return;
         }
         var _loc3_:int = 0;
         var _loc4_:Array = _data.petFastKeyOfString.split(",");
         for each(_loc2_ in _data.activeSkillList)
         {
            if(_loc2_)
            {
               if(_skillEnable)
               {
                  _loc3_ = _loc4_.indexOf(_loc2_.SonType.toString());
               }
               _loc1_ = _itemList[_loc3_] as PetSkillItemViewII;
               if(_loc1_)
               {
                  _loc1_.data = _loc2_;
                  _loc1_.setQuitBtnDisappear();
               }
               _loc3_++;
            }
         }
         _loc3_ = 5;
         for each(_loc2_ in _data.passiveSkillList)
         {
            if(_loc2_)
            {
               _loc1_ = _itemList[_loc3_] as PetSkillItemViewII;
               if(_loc1_)
               {
                  _loc1_.data = _loc2_;
                  _loc1_.setQuitBtnDisappear();
               }
               _loc3_++;
            }
         }
         _loc2_ = null;
      }
      
      private function showView() : void
      {
         var _loc1_:int = 0;
         if(_data)
         {
            _loc1_ = int(_data.grade);
         }
         _lockBg.visible = false;
         _bg.visible = true;
         _titleBg.visible = true;
         _title.visible = true;
         _box.visible = true;
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

