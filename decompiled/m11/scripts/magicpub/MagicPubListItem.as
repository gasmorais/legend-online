package magicpub
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.magicpub.MagicPubInfoMsg;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.templates.MagicPubNpcTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.CursorManagerII;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseIconView;
   
   public class MagicPubListItem extends Component implements ISelectable
   {
      
      private var _back:DisplayObject;
      
      private var _shineBg:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _doubleBmp1:Image;
      
      private var _selected:Boolean;
      
      private var _data:MagicPubInfoMsg;
      
      private var _nameTxt:FilterFrameText;
      
      private var _friendTxt:FilterFrameText;
      
      private var _friendBmp:Image;
      
      private var _greenBar:MovieClip;
      
      public function MagicPubListItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.magicpub.item.Bg");
         _shineBg = ComponentFactory.Instance.creatBitmap("asset.magicpub.list.lightBmp");
         _icon = ComponentFactory.Instance.creatCustomObject("magicpub.suitIcon");
         _doubleBmp1 = ComponentFactory.Instance.creatComponentByStylename("magicpub.item.doubleBmp1");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("magicpub.MagicPubListItem.Name");
         _friendTxt = ComponentFactory.Instance.creatComponentByStylename("magicpub.MagicPubListItem.Friend");
         _friendBmp = ComponentFactory.Instance.creatComponentByStylename("magicpub.item.friendBmp");
         _greenBar = ComponentFactory.Instance.creatCustomObject("magicpub.item.greenBar");
         addChild(_back);
         addChild(_shineBg);
         addChild(_icon);
         addChild(_doubleBmp1);
         addChild(_nameTxt);
         addChild(_friendTxt);
         addChild(_friendBmp);
         addChild(_greenBar);
         _shineBg.visible = false;
         _icon.mouseChildren = _icon.mouseEnabled = false;
      }
      
      private function initEvent() : void
      {
         addEventListener("rollOver",__overHandler);
         addEventListener("rollOut",__outHandler);
         NotificationManager.instance.addEventListener("MAGICPUB_UPDATE_CHAT_VIEW",__updateChatHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__overHandler);
         removeEventListener("rollOut",__outHandler);
         NotificationManager.instance.removeEventListener("MAGICPUB_UPDATE_CHAT_VIEW",__updateChatHandler);
      }
      
      private function __updateChatHandler(param1:NotificationEvent) : void
      {
         data = _data;
      }
      
      public function set data(param1:MagicPubInfoMsg) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         _data = param1;
         var _loc2_:MagicPubNpcTemplateInfo = TempleteManager.instance.magicPubNpcTemplateCate.getTemplateByID(_data.templateId);
         _icon.icon = PathManager.getMagicPubIconPath(_loc2_.IconPath);
         _nameTxt.text = _loc2_.TemplateName;
         var _loc5_:int = int(_data.grades > 4 ? 4 : _data.grades);
         _friendTxt.text = LanguageMgr.GetTranslation("magicpub.MagicPubListItem.friendText",_loc5_);
         _doubleBmp1.visible = _data.isEvent;
         var _loc7_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_data.grades + 1,126);
         if(!_loc7_)
         {
            _loc3_ = 100;
         }
         else
         {
            _loc4_ = int(_data.gp);
            _loc6_ = int(_loc7_.Data);
            _loc3_ = _loc4_ / _loc6_ * 100;
         }
         _greenBar.gotoAndStop(_loc3_);
      }
      
      public function get data() : MagicPubInfoMsg
      {
         return _data;
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         CursorManagerII.instance.showCursorByType("SPACE_NPC_CURSOR");
         if(selected)
         {
            return;
         }
         _shineBg.visible = true;
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         CursorManagerII.instance.showCursorByType("DEFAULT_CURSOR");
         if(selected)
         {
            return;
         }
         _shineBg.visible = false;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         _shineBg.visible = _selected;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_shineBg);
         _shineBg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_doubleBmp1);
         _doubleBmp1 = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_friendTxt);
         _friendTxt = null;
         ObjectUtils.disposeObject(_friendBmp);
         _friendBmp = null;
         ObjectUtils.disposeViolentMc(_greenBar);
         _greenBar = null;
         _data = null;
         super.dispose();
      }
   }
}

