package dreamarena.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import managers.DreamArenaManager;
   import mvc.module.dreamarena.DreamArenaModel;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class DreamAreaDragonSelectSkillItem extends Component
   {
      
      private var _skillIcon1:BaseIconView;
      
      private var _skillIcon2:BaseIconView;
      
      private var _selectBit:Bitmap;
      
      private var _selectKuanBit:Bitmap;
      
      private var _back:Bitmap;
      
      private var _title:FilterFrameText;
      
      private var _selectIdx:int;
      
      private var _skillIds:String;
      
      private var _type:int;
      
      public function DreamAreaDragonSelectSkillItem(param1:int = -1)
      {
         super();
         _type = param1;
         initView();
         initEvent();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_skillIcon1);
         _skillIcon1 = null;
         ObjectUtils.disposeObject(_skillIcon2);
         _skillIcon2 = null;
         ObjectUtils.disposeObject(_selectBit);
         _selectBit = null;
         ObjectUtils.disposeObject(_selectKuanBit);
         _selectKuanBit = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         super.dispose();
      }
      
      private function initView() : void
      {
         _skillIcon1 = ComponentFactory.Instance.creatCustomObject("DreamArenaHeroSkillItem.DragonskillIcon1");
         _skillIcon2 = ComponentFactory.Instance.creatCustomObject("DreamArenaHeroSkillItem.DragonskillIcon2");
         _selectBit = ComponentFactory.Instance.creatBitmap("asset.DreamArena.lookBtn.cck");
         _selectKuanBit = ComponentFactory.Instance.creatBitmap("asset.DreamArena.lookBtn.cLk");
         _back = ComponentFactory.Instance.creatBitmap("asset.DreamArena.lookBtn.sBk");
         _title = ComponentFactory.Instance.creatComponentByStylename("ui.dreamarena.dreamAreaItemTitle");
         addChild(_back);
         addChild(_title);
         addChild(_skillIcon1);
         addChild(_skillIcon2);
         addChild(_selectKuanBit);
         addChild(_selectBit);
         _skillIcon1.name = "0";
         _skillIcon2.name = "1";
         _skillIcon1.buttonMode = true;
         _skillIcon2.buttonMode = true;
         selectIdx = 0;
      }
      
      public function set titleText(param1:String) : void
      {
         _title.text = param1;
      }
      
      private function initEvent() : void
      {
         _skillIcon1.addEventListener("click",iconClickHandler);
         _skillIcon2.addEventListener("click",iconClickHandler);
      }
      
      private function removeEvent() : void
      {
         _skillIcon1.removeEventListener("click",iconClickHandler);
         _skillIcon2.removeEventListener("click",iconClickHandler);
      }
      
      private function iconClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:DisplayObject = param1.currentTarget as DisplayObject;
         var _loc2_:String = _loc3_.name;
         switch(_loc2_)
         {
            case "0":
               selectIdx = 0;
               break;
            case "1":
               selectIdx = 1;
         }
         NotificationManager.instance.sendNotification("DreamAreaDragonSkillChange",_type);
      }
      
      private function get model() : DreamArenaModel
      {
         return DreamArenaManager.instance.model;
      }
      
      public function get selectIdx() : int
      {
         return _selectIdx;
      }
      
      public function set selectIdx(param1:int) : void
      {
         _selectIdx = param1;
         switch(_selectIdx)
         {
            case 0:
               _selectKuanBit.x = -2;
               _selectKuanBit.y = 15;
               _selectBit.x = 38;
               _selectBit.y = 53;
               _skillIcon1.alpha = 1;
               _skillIcon2.alpha = 0.5;
               break;
            case 1:
               _selectKuanBit.x = 50;
               _selectKuanBit.y = 15;
               _selectBit.x = 88;
               _selectBit.y = 53;
               _skillIcon1.alpha = 0.5;
               _skillIcon2.alpha = 1;
         }
      }
      
      public function get skillIds() : String
      {
         return _skillIds;
      }
      
      public function set skillIds(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:SkillTempInfo = null;
         if(_skillIds == param1)
         {
            return;
         }
         _skillIds = param1;
         var _loc4_:Array = _skillIds.split(",");
         if(_loc4_ && _loc4_.length == 2)
         {
            _loc2_ = int(_loc4_[0]);
            _loc3_ = TempleteManager.instance.skillTemplateDic[_loc2_];
            _skillIcon1.icon = IconFactory.getTecIconByIcon(_loc3_.Icons);
            _skillIcon1.tipData = _loc3_;
            _loc2_ = int(_loc4_[1]);
            _loc3_ = TempleteManager.instance.skillTemplateDic[_loc2_];
            _skillIcon2.icon = IconFactory.getTecIconByIcon(_loc3_.Icons);
            _skillIcon2.tipData = _loc3_;
         }
      }
   }
}

