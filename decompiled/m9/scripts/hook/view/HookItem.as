package hook.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.HookContorler;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.view.community.BaseIconView;
   
   public class HookItem extends Sprite implements Disposeable
   {
      
      private var _selectedBack:ScaleFrameImage;
      
      private var _effectback:ScaleFrameImage;
      
      private var _back:ScaleFrameImage;
      
      private var _roomIcon:BaseIconView;
      
      private var _roomName:BaseIconView;
      
      private var _iconBack:Bitmap;
      
      private var _capcity:FilterFrameText;
      
      private var _temp:CampaignTemplate;
      
      public function HookItem()
      {
         super();
         initView();
         initEvent();
         buttonMode = true;
      }
      
      private function initView() : void
      {
         _selectedBack = ComponentFactory.Instance.creatComponentByStylename("core.RoomItemSelectedBack");
         _selectedBack.setFrame(2);
         _effectback = ComponentFactory.Instance.creatComponentByStylename("core.RoomItemEffectBack");
         _back = ComponentFactory.Instance.creatComponentByStylename("core.RoomItemBack");
         _back.setFrame(1);
         _roomIcon = ComponentFactory.Instance.creatCustomObject("core.RoomIcon");
         _roomName = ComponentFactory.Instance.creatCustomObject("core.RoomName",[setPos]);
         _iconBack = ComponentFactory.Instance.creatBitmap("asset.core.RoomItemIconBack");
         _capcity = ComponentFactory.Instance.creatComponentByStylename("hook.RoomCapicity");
         addChild(_effectback);
         addChild(_back);
         addChild(_roomIcon);
         addChild(_roomName);
         addChild(_capcity);
         addChild(_iconBack);
         addChild(_selectedBack);
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__clickHandler);
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__clickHandler);
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         _selectedBack.setFrame(1);
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         _selectedBack.setFrame(2);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_temp)
         {
            control.sendEnterBattle(_temp);
         }
      }
      
      private function get control() : HookContorler
      {
         return FrameControllerManager.instance.hookControler;
      }
      
      public function set temp(param1:CampaignTemplate) : void
      {
         _temp = param1;
         refreshView();
      }
      
      public function get temp() : CampaignTemplate
      {
         return _temp;
      }
      
      public function get selectedBack() : ScaleFrameImage
      {
         return _selectedBack;
      }
      
      private function refreshView() : void
      {
         if(_temp)
         {
            _roomIcon.icon = PathManager.mapInstanceRoomIcon(_temp.CampaignId);
            _roomName.icon = PathManager.mapInstanceRoomName(_temp.CampaignId);
         }
         else
         {
            _roomIcon.icon = null;
            _roomName.icon = null;
         }
         _capcity.text = control.roomState[_temp.CampaignId].toString();
         _capcity.setFrame(1);
         var _loc1_:String = LanguageMgr.GetTranslation("hook.view.HookItem.capcity");
         if(_capcity.text == _loc1_)
         {
            _capcity.setFrame(2);
         }
      }
      
      private function setPos(param1:Object) : void
      {
         if(_roomName.icon)
         {
            _roomName.x = 162 - _roomName.content.width / 2;
            _roomName.y = 46 - _roomName.content.height / 2;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_effectback);
         _effectback = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_roomIcon);
         _roomIcon = null;
         ObjectUtils.disposeObject(_roomName);
         _roomName = null;
         ObjectUtils.disposeObject(_capcity);
         _capcity = null;
         ObjectUtils.disposeObject(_iconBack);
         _iconBack = null;
         ObjectUtils.disposeObject(_selectedBack);
         _selectedBack = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

