package mineField
{
   import com.greensock.TweenMax;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.MineralCarInfo;
   import map.campaign.data.MineralModel;
   import yishi.comm.PackageOut;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   
   public class MineFieldFrame extends Frame implements Disposeable, IManualSize
   {
      
      private var _backLine:Scale9CornerImage;
      
      private var _contentBack:Image;
      
      private var _bottomBg:Image;
      
      private var _remainCount:FilterFrameText;
      
      private var _remainCountNum:FilterFrameText;
      
      private var _startBtn:IconButton;
      
      private var _shopBtn:IconButton;
      
      public function MineFieldFrame()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,315,410);
      }
      
      private function initView() : void
      {
         _backLine = ComponentFactory.Instance.creatComponentByStylename("mineField.backLine");
         _contentBack = ComponentFactory.Instance.creatComponentByStylename("mineField.contentBack");
         _bottomBg = ComponentFactory.Instance.creatComponentByStylename("mineField.bottomBg");
         _remainCount = ComponentFactory.Instance.creatComponentByStylename("mineField.remainCount");
         _remainCountNum = ComponentFactory.Instance.creatComponentByStylename("mineField.remainCountNum");
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("mineField.mineFieldEnterBtn");
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("mineField.mineFieldShopBtn");
         _remainCount.text = LanguageMgr.GetTranslation("mineField.MineFieldFrame.remainCount");
         if(mineralModel && selfCarInfo)
         {
            _remainCountNum.text = mineralModel.maxCount - selfCarInfo.get_count + "";
         }
         else
         {
            _remainCountNum.text = PlayerManager.instance.currentPlayerModel.playerInfo.tramcarCount + "";
         }
         addToContent(_backLine);
         addToContent(_contentBack);
         addToContent(_bottomBg);
         addToContent(_remainCount);
         addToContent(_remainCountNum);
         addToContent(_startBtn);
         addToContent(_shopBtn);
      }
      
      private function initEvent() : void
      {
         _startBtn.addEventListener("click",_startBtnClick);
         _shopBtn.addEventListener("click",_shopBtnClick);
         addEventListener("response",__frameResponse);
      }
      
      private function refreshView() : void
      {
      }
      
      private function removeEvent() : void
      {
         if(_startBtn)
         {
            _startBtn.removeEventListener("click",_startBtnClick);
         }
         if(_shopBtn)
         {
            _startBtn.removeEventListener("click",_shopBtnClick);
         }
         removeEventListener("response",__frameResponse);
      }
      
      private function _startBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:PackageOut = new PackageOut(8633);
         SocketManager.instance.socket.send(_loc2_);
      }
      
      private function _shopBtnClick(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("shop",11);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function get mineralModel() : MineralModel
      {
         return CampaignManager.instance.mineralModel;
      }
      
      private function get selfCarInfo() : MineralCarInfo
      {
         return CampaignManager.instance.mineralModel.selfCarInfo;
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("mineField.MineFieldFrame.title");
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         TweenMax.killChildTweensOf(this);
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

