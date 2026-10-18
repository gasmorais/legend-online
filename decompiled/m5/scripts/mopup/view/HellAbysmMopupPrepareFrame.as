package mopup.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.outyard.AbysmModel;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.ConfigManager;
   import yishi.manager.OutyardManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.scene.SceneManager;
   import yishi.utils.DateFormatter;
   import yishi.view.tips.MessageTipManager;
   
   public class HellAbysmMopupPrepareFrame extends Frame implements IManualSize
   {
      
      private static const MAZE_MOPUP:int = 2;
      
      private static const OPERATION_MOPUP:int = 1;
      
      private var _mopupHowCounts:Bitmap;
      
      private var _mopupCounts:Bitmap;
      
      private var _mopupUseTime:Bitmap;
      
      private var _mopupBack0:Scale9CornerImage;
      
      private var _mopupBack1:Scale9CornerImage;
      
      private var _mopupBack2:ScaleBitmapImage;
      
      private var _mopupInputBack:ScaleBitmapImage;
      
      private var _mopupCountsTxt:FilterFrameText;
      
      private var _mopupUseTimeTxt:FilterFrameText;
      
      private var _mopupTipTitle:FilterFrameText;
      
      private var _mopupTipTxt:FilterFrameText;
      
      private var _startMopupBtn:IconButton;
      
      private var _changeBtn:IconButton;
      
      private var _mazeTime:int;
      
      private var _turnCounts:int;
      
      private var inputMaxIndex:String;
      
      private var _mopupCountsNum:int;
      
      public function HellAbysmMopupPrepareFrame()
      {
         super();
         initView();
         initData();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,555,315);
      }
      
      private function initView() : void
      {
         if(SceneManager.instance.currentType != "CASTLE_SCENE" && SceneManager.instance.currentType != "SPACE_SCENE")
         {
            SceneManager.instance.setScene("CASTLE_SCENE");
         }
         _mopupHowCounts = ComponentFactory.Instance.creatBitmap("asset.mopup.MopupHowTurns");
         _mopupCounts = ComponentFactory.Instance.creatBitmap("asset.mopup.MopupTurns");
         _mopupUseTime = ComponentFactory.Instance.creatBitmap("asset.mopup.MopupUseTime");
         _mopupBack0 = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupBack0");
         _mopupBack1 = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupBack1");
         _mopupBack2 = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupBack2");
         _mopupInputBack = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupPrepareInputBack");
         _mopupCountsTxt = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupCountsInputTxt");
         _mopupUseTimeTxt = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupUseTimeTxt");
         _mopupTipTitle = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupTipTitle");
         _mopupTipTxt = ComponentFactory.Instance.creatComponentByStylename("mopup.MopupTipTxt");
         _startMopupBtn = ComponentFactory.Instance.creatComponentByStylename("mopup.StartMopupBtn");
         _changeBtn = ComponentFactory.Instance.creatComponentByStylename("mopup.changeMopupBtn");
         addToContent(_mopupBack0);
         addToContent(_mopupBack1);
         addToContent(_mopupBack2);
         addToContent(_mopupInputBack);
         _mopupInputBack.x = 428;
         addToContent(_mopupHowCounts);
         addToContent(_mopupCounts);
         addToContent(_mopupUseTime);
         _mopupUseTime.y = 61;
         addToContent(_mopupCountsTxt);
         _mopupCountsTxt.x = 430;
         addToContent(_mopupUseTimeTxt);
         _mopupUseTimeTxt.y = 63;
         addToContent(_mopupTipTitle);
         _mopupTipTitle.text = LanguageMgr.GetTranslation("mopup.view.MazeMopupPrepareFrame.mopupTipTitle");
         addToContent(_mopupTipTxt);
         addToContent(_startMopupBtn);
         _startMopupBtn.y = 108;
         addToContent(_changeBtn);
         _changeBtn.y = 170;
      }
      
      public function initData() : void
      {
         _mopupTipTxt.htmlText = LanguageMgr.GetTranslation("abysm.abysmView.mopupTip02",model.maxIndex - 1,model.maxIndex - 1);
         _mazeTime = 30;
         inputMaxIndex = model.maxIndex.toString();
         _mopupCountsTxt.text = (model.maxIndex - 1).toString();
         _turnCounts = model.maxIndex - model.currentLayer;
         _mopupUseTimeTxt.text = DateFormatter.getConsortiaCountDate(_turnCounts * _mazeTime);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _startMopupBtn.addEventListener("click",__startMopupHandler);
         _mopupCountsTxt.addEventListener("change",__textChangeHandler);
         _changeBtn.addEventListener("click",__changeMopupHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_startMopupBtn)
         {
            _startMopupBtn.removeEventListener("click",__startMopupHandler);
         }
         if(_mopupCountsTxt)
         {
            _mopupCountsTxt.removeEventListener("change",__textChangeHandler);
         }
         if(_changeBtn)
         {
            _changeBtn.removeEventListener("click",__changeMopupHandler);
         }
      }
      
      private function __changeMopupHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("mopup.view.RemoteMopupPrepareFrame.checkTxt");
         var _loc3_:String = LanguageMgr.GetTranslation("mopup.view.RemoteMopupPrepareFrame.content");
         SharedManagerHelper.ins.needAlert("mopup.view.AbysmMopupPrepareFrame.changeBtn",alertBack,_loc2_,_loc3_,"remotepet");
      }
      
      private function alertBack() : void
      {
         OutyardManager.instance.abysmSendInfo(3);
      }
      
      private function __startMopupHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:Boolean = Boolean(PlayerManager.instance.currentPlayerModel.isInAAS);
         var _loc4_:Boolean = Boolean(ConfigManager.info.AAS);
         if(_loc3_ && _loc4_ && PlayerManager.instance.currentPlayerModel.indulgeTime / 3600 >= 3)
         {
            _loc2_ = LanguageMgr.GetTranslation("remotepet.mopup.inAAS");
            MessageTipManager.instance().show(_loc2_);
            _mopupCountsTxt.text = inputMaxIndex;
            __textChangeHandler(null);
            return;
         }
         if(int(_mopupCountsTxt.text) == 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.view.RemoteMopupPrepareFrame.layerTipData1");
            MessageTipManager.instance().show(_loc2_);
            _mopupCountsTxt.text = inputMaxIndex;
            __textChangeHandler(null);
            return;
         }
         if(int(_mopupCountsTxt.text) < model.currentLayer)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.view.RemoteMopupPrepareFrame.layerTipData2");
            MessageTipManager.instance().show(_loc2_);
            _mopupCountsTxt.text = inputMaxIndex;
            __textChangeHandler(null);
            return;
         }
         if(int(_mopupCountsTxt.text) > int(inputMaxIndex))
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.view.RemoteMopupPrepareFrame.layerTipData3");
            MessageTipManager.instance().show(_loc2_);
            _mopupCountsTxt.text = inputMaxIndex;
            __textChangeHandler(null);
            return;
         }
         OutyardManager.instance.sendMopup(int(_mopupCountsTxt.text) + 1);
         OutyardManager.instance.abysmModel.mopupList = [];
         _startMopupBtn.enable = false;
         dispose();
      }
      
      private function __textChangeHandler(param1:Event) : void
      {
         _mopupCountsNum = int(_mopupCountsTxt.text);
         _mopupCountsNum = _mopupCountsNum < 1 ? 1 : _mopupCountsNum;
         _mopupCountsTxt.text = String(_mopupCountsNum);
         _turnCounts = _mopupCountsNum - model.currentLayer + 1;
         if(_turnCounts < 0)
         {
            _mopupUseTimeTxt.text = DateFormatter.getConsortiaCountDate(0);
         }
         else
         {
            _mopupUseTimeTxt.text = DateFormatter.getConsortiaCountDate(_turnCounts * _mazeTime);
         }
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
      
      public function show(param1:Object = null) : void
      {
         titleText = LanguageMgr.GetTranslation("abysm.abysmView.mopupTip03");
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function get model() : AbysmModel
      {
         return OutyardManager.instance.abysmModel;
      }
      
      private function unint() : void
      {
         ObjectUtils.disposeObject(_mopupHowCounts);
         _mopupHowCounts = null;
         ObjectUtils.disposeObject(_mopupCounts);
         _mopupCounts = null;
         ObjectUtils.disposeObject(_mopupUseTime);
         _mopupUseTime = null;
         ObjectUtils.disposeObject(_mopupBack0);
         _mopupBack0 = null;
         ObjectUtils.disposeObject(_mopupBack1);
         _mopupBack1 = null;
         ObjectUtils.disposeObject(_mopupBack2);
         _mopupBack2 = null;
         ObjectUtils.disposeObject(_mopupInputBack);
         _mopupInputBack = null;
         ObjectUtils.disposeObject(_mopupCountsTxt);
         _mopupCountsTxt = null;
         ObjectUtils.disposeObject(_mopupUseTimeTxt);
         _mopupUseTimeTxt = null;
         ObjectUtils.disposeObject(_mopupTipTitle);
         _mopupTipTitle = null;
         ObjectUtils.disposeObject(_mopupTipTxt);
         _mopupTipTxt = null;
         ObjectUtils.disposeObject(_startMopupBtn);
         _startMopupBtn = null;
         ObjectUtils.disposeObject(_changeBtn);
         _changeBtn = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unint();
         super.dispose();
      }
   }
}

