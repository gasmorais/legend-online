package remotepet.views
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.RemotePetEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.RemotePetManager;
   import mvc.module.remotepet.RemotePetModel;
   import remotepet.RemotePetOrderFrame;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.tips.MessageTipManager;
   
   public class RemotePetInfoView extends Component
   {
      
      private var _back:Bitmap;
      
      private var _currText:FilterFrameText;
      
      private var _maxText:FilterFrameText;
      
      private var _rankText:FilterFrameText;
      
      private var _startBtn:IconButton;
      
      private var _nextBtn:IconButton;
      
      private var _numBitmap:BitmapData;
      
      private var _petFightImg:Bitmap;
      
      private var _petFightNum:Sprite;
      
      private var _friendPetFightImg:Bitmap;
      
      private var _friendPetFightNum:Sprite;
      
      private var _sortFrame:RemotePetOrderFrame;
      
      public function RemotePetInfoView()
      {
         super();
         initView();
         addEvent();
         __commitHandler(null);
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.remotepet.infoBack");
         _petFightNum = new Sprite();
         _petFightNum.x = 40;
         _petFightNum.y = 155;
         _friendPetFightNum = new Sprite();
         _friendPetFightNum.x = 250;
         _friendPetFightNum.y = 155;
         _currText = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetInfoView.currText");
         _numBitmap = ComponentFactory.Instance.creatBitmapData("asset.remotepet.numberFight");
         _maxText = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetInfoView.maxText");
         _rankText = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetInfoView.rankText");
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetInfoView.startBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetInfoView.nextBtn");
         _petFightImg = ComponentFactory.Instance.creatBitmap("asset.remotepet.petFightImg");
         _friendPetFightImg = ComponentFactory.Instance.creatBitmap("asset.remotepet.friendFightImg");
         addChild(_back);
         addChild(_currText);
         addChild(_maxText);
         addChild(_rankText);
         addChild(_startBtn);
         _startBtn.visible = false;
         addChild(_nextBtn);
         _nextBtn.visible = false;
         addChild(_petFightImg);
         addChild(_friendPetFightImg);
         addChild(_petFightNum);
         addChild(_friendPetFightNum);
         NumberViewUtils.refreshValue(0,_petFightNum,_numBitmap,18,18,14,18,"0123456789");
         NumberViewUtils.refreshValue(0,_friendPetFightNum,_numBitmap,18,18,14,18,"0123456789");
         _rankText.htmlText = "<a href =\'event: \'><u>(" + LanguageMgr.GetTranslation("remotepet.rankText") + ")" + "</u></a>";
         _rankText.mouseEnabled = true;
      }
      
      private function addEvent() : void
      {
         model.addEventListener("COMMIT",__commitHandler);
         _rankText.addEventListener("click",__rankHandler);
         _startBtn.addEventListener("click",__startHandler);
         _nextBtn.addEventListener("click",__toWarHandler);
      }
      
      private function __rankHandler(param1:MouseEvent) : void
      {
         if(!_sortFrame)
         {
            _sortFrame = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetOrderFrame");
            _sortFrame.show();
            this.parent.parent.addChild(_sortFrame);
            _sortFrame.x = 1050;
            if(StageReferance.gameStageWidth < 1800)
            {
               this.parent.parent.x = 34;
            }
            _sortFrame.visible = true;
            return;
         }
         _sortFrame.visible = !_sortFrame.visible;
      }
      
      private function __startHandler(param1:MouseEvent) : void
      {
         alertBack(true,true);
         _sortFrame && _sortFrame.parent && _sortFrame.parent.removeChild(_sortFrame);
         _sortFrame = null;
      }
      
      private function alertBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(model.enterWarNum <= 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("remotepet.views.RemotePetInfoView.tip"));
               return;
            }
            RemotePetManager.instance.saveRemotePetInfo(true);
            FrameControllerManager.instance.remotePetController.startFrameByType(2);
         }
      }
      
      private function __toWarHandler(param1:MouseEvent) : void
      {
         if(model.enterWarNum <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("remotepet.views.RemotePetInfoView.tip"));
            return;
         }
         FrameControllerManager.instance.remotePetController.startFrameByType(2);
      }
      
      private function __commitHandler(param1:RemotePetEvent) : void
      {
         if(model.isFrist)
         {
            _startBtn.visible = true;
            _nextBtn.visible = false;
         }
         else
         {
            _startBtn.visible = false;
            _nextBtn.visible = true;
         }
         var _loc2_:int = int(model.turnInfo.currTurn);
         if(_loc2_ >= 100)
         {
            _loc2_ = 100;
         }
         _currText.text = LanguageMgr.GetTranslation("remotepet.currText") + " " + _loc2_;
         _maxText.text = LanguageMgr.GetTranslation("remotepet.maxText") + " " + model.turnInfo.maxTurn;
         var _loc4_:int = 0;
         if(model.petListInfo.petList[7])
         {
            _loc4_ = int(model.petListInfo.petList[7].fightPower);
         }
         var _loc3_:int = 0;
         for(var _loc5_:String in model.petListInfo.petList)
         {
            if(model.petListInfo.petList[_loc5_] && int(_loc5_) != 7)
            {
               _loc3_ += model.petListInfo.petList[_loc5_].fightPower;
            }
         }
         NumberViewUtils.refreshValue(_loc3_,_petFightNum,_numBitmap,18,18,14,18,"0123456789");
         NumberViewUtils.refreshValue(_loc4_,_friendPetFightNum,_numBitmap,18,18,14,18,"0123456789");
         _friendPetFightNum.x = 230;
      }
      
      private function removeEvent() : void
      {
         model.removeEventListener("COMMIT",__commitHandler);
         _rankText.removeEventListener("click",__rankHandler);
         _startBtn.removeEventListener("click",__startHandler);
         _nextBtn.removeEventListener("click",__toWarHandler);
      }
      
      private function get model() : RemotePetModel
      {
         return RemotePetManager.instance.model;
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_currText);
         _currText = null;
         ObjectUtils.disposeObject(_maxText);
         _maxText = null;
         ObjectUtils.disposeObject(_rankText);
         _rankText = null;
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_petFightImg);
         _petFightImg = null;
         ObjectUtils.disposeObject(_friendPetFightImg);
         _friendPetFightImg = null;
         ObjectUtils.disposeObject(_numBitmap);
         _numBitmap = null;
         ObjectUtils.disposeObject(_petFightNum);
         _petFightNum = null;
         ObjectUtils.disposeObject(_friendPetFightNum);
         _friendPetFightNum = null;
         ObjectUtils.disposeObject(_sortFrame);
         _sortFrame = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
      }
   }
}

