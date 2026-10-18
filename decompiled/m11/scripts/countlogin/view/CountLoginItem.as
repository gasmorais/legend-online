package countlogin.view
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.player.TakeLoginReward;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.comm.PackageOut;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.CountLoginDropTemplate;
   import yishi.events.PlayerEvent;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.view.community.BaseItemView;
   
   public class CountLoginItem extends Sprite implements Disposeable, IManualSize
   {
      
      private var _text:FilterFrameText;
      
      private var _hBox:HBox;
      
      private var _btn:IconButton;
      
      private var _receivedIcon:Image;
      
      private var _index:int;
      
      private var _isDie:Boolean = false;
      
      public function CountLoginItem()
      {
         super();
         initView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,100,43);
      }
      
      private function initView() : void
      {
         _text = ComponentFactory.Instance.creatComponentByStylename("countlogin.Item.Txt");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("countlogin.Item.Contain");
         _btn = ComponentFactory.Instance.creatComponentByStylename("countlogin.Item.Btn");
         _receivedIcon = ComponentFactory.Instance.creatComponentByStylename("countlogin.CountedTxt_2");
         addChild(_text);
         addChild(_hBox);
         addChild(_btn);
         addChild(_receivedIcon);
         _receivedIcon.mouseEnabled = _receivedIcon.mouseChildren = false;
         _receivedIcon.alpha = 0;
      }
      
      private function initEvent() : void
      {
         _btn.addEventListener("click",__clickHandler);
         playerInfo.addEventListener("RELOGINPROCESS_UPDATE",__updateHandler);
      }
      
      private function removeEvent() : void
      {
         _btn && _btn.removeEventListener("click",__clickHandler);
         playerInfo.removeEventListener("RELOGINPROCESS_UPDATE",__updateHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc3_:PackageOut = new PackageOut(8496);
         var _loc2_:TakeLoginReward = new TakeLoginReward();
         _loc2_.index = _index;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      private function __updateHandler(param1:PlayerEvent) : void
      {
         removeEvent();
         refreshView();
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         if(_isDie)
         {
            return;
         }
         var _loc1_:String = LanguageMgr.GetTranslation("countlogin.view.CountLoginItem.loginText");
         var _loc4_:String = LanguageMgr.GetTranslation("countlogin.view.CountLoginItem.dayText");
         _text.htmlText = _loc1_ + " <font color=\'#15c425\'>" + _index + "</font> " + _loc4_;
         var _loc2_:Boolean = Boolean(playerInfo.checkIsReceived(_index));
         if(_loc2_)
         {
            _receivedIcon.alpha = 1;
            _btn.visible = false;
         }
         var _loc3_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.reloginCount);
         _btn.enable = _index <= _loc3_ && !_loc2_;
         if(_btn.enable)
         {
            initEvent();
         }
         refreshDrop();
      }
      
      private function refreshDrop() : void
      {
         var _loc4_:int = 0;
         var _loc1_:CountLoginDropTemplate = null;
         var _loc5_:GoodsInfo = null;
         var _loc2_:BaseItemView = null;
         ObjectUtils.disposeAllChildren(_hBox);
         var _loc3_:Array = TempleteManager.instance.countLoginDropTemplateCate.getTemplatesByIndex(_index);
         _loc3_.sort(dropsSortFunc);
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc1_ = _loc3_[_loc4_] as CountLoginDropTemplate;
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = _loc1_.ItemId;
            _loc5_.count = _loc1_.Data;
            _loc2_ = ComponentFactory.Instance.creatCustomObject("countlogin.DropItem");
            _loc2_.data = _loc5_;
            _hBox.addChild(_loc2_);
            _loc4_++;
         }
      }
      
      private function dropsSortFunc(param1:CountLoginDropTemplate, param2:CountLoginDropTemplate) : int
      {
         if(param1.ItemId == -100)
         {
            return -1;
         }
         if(param2.ItemId == -100)
         {
            return 1;
         }
         if(param1.ItemId == -500)
         {
            return -1;
         }
         if(param2.ItemId == -500)
         {
            return 1;
         }
         if(param1.ItemId == -300)
         {
            return -1;
         }
         if(param2.ItemId == -300)
         {
            return 1;
         }
         if(param1.ItemId == 2050605)
         {
            return 1;
         }
         if(param2.ItemId == 2050605)
         {
            return -1;
         }
         return param1.ItemId >= param2.ItemId ? -1 : 1;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         if(_isDie)
         {
            return;
         }
         _isDie = true;
         removeEvent();
         if(_text)
         {
            _text.dispose();
         }
         _text = null;
         if(_btn)
         {
            _btn.dispose();
         }
         _btn = null;
         if(_receivedIcon)
         {
            _receivedIcon.dispose();
         }
         _receivedIcon = null;
         if(_hBox)
         {
            _hBox.disposeAllChildren();
            _hBox.dispose();
         }
         ObjectUtils.disposeAllChildren(_hBox);
         _hBox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

