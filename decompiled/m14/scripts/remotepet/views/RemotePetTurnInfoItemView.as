package remotepet.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import events.RemotePetEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.RemotePetManager;
   import mvc.module.remotepet.RemotePetModel;
   import mvc.module.remotepet.RemotePetTurnItemInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.IconFactory;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class RemotePetTurnInfoItemView extends Component
   {
      
      private var _back:ScaleFrameImage;
      
      private var _icon:BaseIconView;
      
      private var _numberImg:BitmapData;
      
      private var _numberSp:Sprite;
      
      private var _ownerImg:Bitmap;
      
      private var _filter:IFilterFormat;
      
      private var _data:RemotePetTurnItemInfo;
      
      private var _lastClickTime:int = 0;
      
      private var _mc:MovieClip;
      
      public function RemotePetTurnInfoItemView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetTurnInfoItemView.back",[true]);
         _icon = ComponentFactory.Instance.creatCustomObject("remotepet.RemotePetTurnInfoItemView.icon");
         _numberImg = ComponentFactory.Instance.creatBitmapData("asset.remotepet.numberTurn");
         _ownerImg = ComponentFactory.Instance.creatBitmap("asset.remotepet.ownerImg");
         _numberSp = new Sprite();
         _numberSp.x = -10;
         _numberSp.y = -18;
         _icon.useHandCursor = true;
         _icon.buttonMode = true;
         addChild(_icon);
         addChild(_back);
         addChild(_numberSp);
         _numberSp.visible = false;
         addChild(_ownerImg);
         _ownerImg.visible = false;
         _back.setFrame(1);
         _filter = new UIFilter();
      }
      
      public function get data() : RemotePetTurnItemInfo
      {
         return _data;
      }
      
      public function set data(param1:RemotePetTurnItemInfo) : void
      {
         if(_data == param1)
         {
            return;
         }
         _data = param1;
         if(_data)
         {
            freshView();
            this.tipData = _data;
         }
         else
         {
            this.tipData = null;
         }
      }
      
      private function clean() : void
      {
         _back.setFrame(1);
         _filter.setNormalFilter(this);
         _numberSp.visible = false;
         _ownerImg.visible = false;
         if(_mc && _mc.parent)
         {
            _mc.parent.removeChild(_mc);
            _mc.stop();
            _mc = null;
         }
      }
      
      private function freshView() : void
      {
         clean();
         if(!_data)
         {
            return;
         }
         if(_data.tempInfo.Index == model.turnInfo.currTurn && _data.tempInfo.Type == 1 && _data.tempInfo.Index % 5 != 0)
         {
            _back.setFrame(4);
            _mc = ComponentFactory.Instance.creatCustomObject("asset.remotepet.normalEffect");
            addChild(_mc);
         }
         if(_data.tempInfo.Type == 2)
         {
            _back.setFrame(2);
            _icon.icon = IconFactory.getRemotePetIconPath(_data.tempInfo.Icon);
            if(model.turnInfo.specialIndexOfArray.indexOf(_data.tempInfo.Index + "") >= 0)
            {
               _ownerImg.visible = true;
            }
         }
         if(_data.tempInfo.Index % 5 == 0)
         {
            _back.setFrame(3);
            _icon.icon = IconFactory.getRemotePetIconPath(_data.tempInfo.Icon);
         }
         if(_data.tempInfo.Index == model.turnInfo.currTurn && _data.tempInfo.Index % 5 == 0)
         {
            _mc = ComponentFactory.Instance.creatCustomObject("asset.remotepet.bossEffect");
            addChild(_mc);
         }
         if(_data.tempInfo.Index < model.turnInfo.currTurn && _data.tempInfo.Type == 1)
         {
            _filter.setGrayFilter(this);
         }
         NumberViewUtils.refreshValue(_data.tempInfo.Index,_numberSp,_numberImg,20,24,10,20,"1234567890");
         if(_data.tempInfo.Index >= 10)
         {
            _numberSp.x = -16;
         }
         else
         {
            _numberSp.x = -10;
         }
         if(_numberSp)
         {
            if(_data.tempInfo.Type != 2 && _data.tempInfo.Index % 5 != 0)
            {
               _numberSp.visible = true;
            }
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         if(_data.tempInfo.Type == 2)
         {
            if(model.turnInfo.specialIndexOfArray.indexOf(_data.tempInfo.Index + "") >= 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("remotepet.RemotePetTurnInfoItemView.command03"));
               return;
            }
         }
         if(_data.tempInfo.Index < model.turnInfo.currTurn && _data.tempInfo.Type != 2)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("remotepet.RemotePetTurnInfoItemView.command01"));
            return;
         }
         if(_data.tempInfo.Index > model.turnInfo.currTurn)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("remotepet.RemotePetTurnInfoItemView.command02"));
            return;
         }
         if(_data.tempInfo.Index == model.turnInfo.currTurn || _data.tempInfo.Type == 2 && _data.tempInfo.Index <= model.turnInfo.maxTurn)
         {
            _loc3_ = getTimer();
            if(_loc3_ - _lastClickTime < 1000)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
               return;
            }
            _lastClickTime = _loc3_;
            if(_data.tempInfo.Type == 1)
            {
               if(model.turnInfo.currTurn < model.maxMopupTurn)
               {
                  FrameControllerManager.instance.openControllerByInfo("mopup",5,1);
                  return;
               }
            }
            _loc2_ = _data.tempInfo.Type == 2;
            RemotePetManager.instance.sendFight(_data.tempInfo.Index,_loc2_);
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__clickHandler);
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
         model.addEventListener("COMMIT",__commitHandler);
      }
      
      private function __commitHandler(param1:RemotePetEvent) : void
      {
         freshView();
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_numberImg);
         _numberImg = null;
         ObjectUtils.disposeObject(_numberSp);
         _numberSp = null;
         ObjectUtils.disposeObject(_mc);
         _mc = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function removeEvent() : void
      {
         model.removeEventListener("COMMIT",__commitHandler);
         removeEventListener("click",__clickHandler);
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
      }
      
      private function get model() : RemotePetModel
      {
         return RemotePetManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

