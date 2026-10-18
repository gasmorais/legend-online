package map.campaign.view.ui.snowball
{
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.view.ui.snowball.item.SnowBallRankItem;
   import utils.LogicUtils;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   
   public class SnowBallRankView extends Component
   {
      
      private var _bit1:MutipleImage;
      
      private var _titleNameTxt:FilterFrameText;
      
      private var _titleNumTxt:FilterFrameText;
      
      private var _itemBox:VBox;
      
      private var _bit2:Bitmap;
      
      private var _list:Vector.<SnowBallRankItem>;
      
      private var _switchBtn:Sprite;
      
      private var _arrowImg:Bitmap;
      
      private var _helpBtn:BaseButton;
      
      private const MAX:int = 8;
      
      private var _isShow:Boolean = false;
      
      public function SnowBallRankView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:SnowBallRankItem = null;
         var _loc2_:int = 0;
         _bit1 = ComponentFactory.Instance.creatComponentByStylename("snowball.SnowBallRankView.bg");
         _titleNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.snowball.titleNameTxt");
         _titleNumTxt = ComponentFactory.Instance.creatComponentByStylename("ui.snowball.titleNumTxt");
         _itemBox = ComponentFactory.Instance.creatCustomObject("ui.snowball.scoreVb");
         _bit2 = ComponentFactory.Instance.creatBitmap("asset.snowball.st");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("ui.snowballRank.HelpBtn");
         _arrowImg = ComponentFactory.Instance.creatBitmap("asset.campaign.GVGManageViewArrowImg");
         _switchBtn = ComponentFactory.Instance.creatCustomObject("ui.snowball.SwitchBtn");
         _switchBtn.graphics.beginFill(16711680,0);
         _switchBtn.graphics.drawRect(0,0,28,89);
         _switchBtn.graphics.endFill();
         _switchBtn.buttonMode = true;
         _switchBtn.addChild(_arrowImg);
         addChild(_bit1);
         addChild(_switchBtn);
         addChild(_titleNameTxt);
         addChild(_titleNumTxt);
         addChild(_itemBox);
         addChild(_bit2);
         addChild(_helpBtn);
         _titleNameTxt.text = LanguageMgr.GetTranslation("snowball.playerTitle");
         _titleNumTxt.text = LanguageMgr.GetTranslation("snowball.pickSkillNum.text");
         _list = new Vector.<SnowBallRankItem>();
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new SnowBallRankItem();
            _list[_loc2_] = _loc1_;
            _loc2_++;
         }
      }
      
      public function show() : void
      {
         resize();
         LayerManager.Instance.addToLayer(this,4,false,false,0,1);
      }
      
      private function initEvent() : void
      {
         if(_switchBtn)
         {
            _switchBtn.addEventListener("click",__switchBtnClickHandler);
         }
         MsgMan.addObserver("ActiveFlushRank",this,refreshHandler);
         _helpBtn.addEventListener("click",__helpHandler);
      }
      
      private function removeEvent() : void
      {
         if(_switchBtn)
         {
            _switchBtn.removeEventListener("click",__switchBtnClickHandler);
         }
         MsgMan.removeObserver("ActiveFlushRank",this,refreshHandler);
         _helpBtn.removeEventListener("click",__helpHandler);
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:Frame = ComponentFactory.Instance.creatComponentByStylename("ui.snowball.helpFrame");
         _loc2_["show"]();
      }
      
      private function refreshHandler(param1:String, param2:Object) : void
      {
         var _loc3_:Array = param2 as Array;
         refreshView(_loc3_);
      }
      
      public function resize() : void
      {
         if(_isShow)
         {
            doShow();
         }
         else
         {
            doHide();
         }
         y = (StageReferance.stageHeight - this.displayHeight) * 0.5 - 40;
      }
      
      private function __switchBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _isShow = !_isShow;
         if(_isShow)
         {
            doShow();
         }
         else
         {
            doHide();
         }
      }
      
      private function doShow() : void
      {
         _arrowImg.scaleX = -1;
         _arrowImg.x = 24;
         TweenMax.killTweensOf(this);
         TweenMax.to(this,0.5,{"x":StageReferance.stageWidth - this.displayWidth});
      }
      
      private function doHide() : void
      {
         _arrowImg.scaleX = 1;
         _arrowImg.x = 6;
         TweenMax.killTweensOf(this);
         TweenMax.to(this,0.5,{"x":StageReferance.stageWidth - 28});
      }
      
      private function refreshView(param1:Array) : void
      {
         var _loc2_:SnowBallRankItem = null;
         var _loc6_:int = 0;
         if(param1 == null)
         {
            return;
         }
         var _loc3_:int = int(param1.length);
         ObjectUtils.removeChildAllChildrenFromStage(_itemBox);
         _itemBox.beginChanges();
         var _loc4_:String = "0";
         var _loc7_:String = PlayerManager.instance.currentPlayerModel.playerInfo.userId + "";
         var _loc5_:String = PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc2_ = _list[_loc6_];
            _loc2_.data = param1[_loc6_];
            _itemBox.addChild(_loc2_);
            if(param1[_loc6_].userId == _loc7_ && param1[_loc6_].serverName == _loc5_)
            {
               _loc4_ = param1[_loc6_].score;
            }
            _loc6_++;
         }
         _itemBox.commitChanges();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         TweenMax.killTweensOf(this);
         ObjectUtils.disposeAllChildren(_switchBtn);
         ObjectUtils.disposeObject(_switchBtn);
         _switchBtn = null;
         ObjectUtils.disposeObject(_bit1);
         _bit1 = null;
         ObjectUtils.disposeObject(_titleNameTxt);
         _titleNameTxt = null;
         ObjectUtils.disposeObject(_titleNumTxt);
         _titleNumTxt = null;
         ObjectUtils.disposeObject(_itemBox);
         _itemBox = null;
         ObjectUtils.disposeObject(_bit2);
         _bit2 = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         LogicUtils.disposeDisplayCollection(_list);
         _list = null;
         super.dispose();
      }
   }
}

