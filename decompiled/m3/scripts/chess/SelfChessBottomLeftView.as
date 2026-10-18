package chess
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.chess.SelfChessManager;
   import mvc.module.chess.SelfChessModel;
   import mvc.module.chess.SelfChessPlayerInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.base.ProgressPanel;
   import yishi.view.tips.MessageTipManager;
   
   public class SelfChessBottomLeftView extends Sprite
   {
      
      public var _bleftBg:MutipleImage;
      
      public var _winTxt:FilterFrameText;
      
      public var _hasGoldTxt:FilterFrameText;
      
      public var _bleftLvTxt:FilterFrameText;
      
      public var _bLeftAddTxt:FilterFrameText;
      
      public var _bleftGoldTxt:FilterFrameText;
      
      private var upBtn:BaseButton;
      
      private var progress:ProgressPanel;
      
      public var _winStateImg:ScaleFrameImage;
      
      private var _tipContainer:Component;
      
      private var _currGold:int;
      
      public function SelfChessBottomLeftView()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _bleftBg = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.bleftBg");
         _winTxt = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.winTxt");
         _hasGoldTxt = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.hasGoldTxt");
         _bleftLvTxt = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.bleftLvTxt");
         _bLeftAddTxt = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.bLeftAddTxt");
         _bleftGoldTxt = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.bleftGoldTxt");
         _winStateImg = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.winStateImg");
         _tipContainer = ComponentFactory.Instance.creatCustomObject("ui.btLeftGoldSp");
         upBtn = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.blupBtn");
         progress = ComponentFactory.Instance.creatCustomObject("ui.selfchess.blprogress");
         progress.initView("asset.selfchess.progressBg1","asset.selfchess.progressBar1","ui.selfchess.blProgressTxt");
         addChild(_bleftBg);
         addChild(upBtn);
         addChild(_winTxt);
         addChild(_hasGoldTxt);
         addChild(_bleftLvTxt);
         addChild(_bLeftAddTxt);
         addChild(_bleftGoldTxt);
         addChild(progress);
         addChild(_winStateImg);
         addChild(_tipContainer);
         var _loc2_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.selfchess.hasGolden");
         var _loc1_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.selfchess.goldenIcon");
         _loc1_.x = 92;
         _tipContainer.addChild(_loc2_);
         _tipContainer.addChild(_loc1_);
         _tipContainer.addChild(_hasGoldTxt);
      }
      
      private function initEvent() : void
      {
         upBtn.addEventListener("click",upClickHandler);
      }
      
      private function removeEvent() : void
      {
         upBtn.removeEventListener("click",upClickHandler);
      }
      
      private function upClickHandler(param1:MouseEvent) : void
      {
         if(_currGold < 4)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("selfchess.buy.noGold"));
            return;
         }
         SelfChessManager.Ins.sendOp(7);
      }
      
      public function refreshView() : void
      {
         var _loc5_:UpgradeTemplateInfo = null;
         var _loc2_:UpgradeTemplateInfo = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc1_:int = 0;
         var _loc6_:SelfChessPlayerInfo = model.selfInfo;
         if(_loc6_)
         {
            _currGold = _loc6_.gold;
            _winTxt.text = "" + _loc6_.winCount;
            _hasGoldTxt.text = "" + _currGold;
            _bLeftAddTxt.text = "4";
            _bleftGoldTxt.text = "4";
            _bleftLvTxt.text = "" + _loc6_.grade;
            _loc5_ = TempleteManager.instance.getTemplateByLevelAndType(_loc6_.grade,81);
            _loc2_ = TempleteManager.instance.getTemplateByLevelAndType(_loc6_.grade + 1,81);
            _loc3_ = int(_loc5_.Data);
            _loc4_ = "";
            _loc4_ = _loc4_ + getStrForTemp(_loc5_,"selfchess.upgradeBtn.currTip");
            if(_loc2_ == null)
            {
               upBtn.enable = false;
               progress.showMax();
            }
            else
            {
               upBtn.enable = true;
               progress.progressValue(_loc6_.exp,_loc3_);
               _loc4_ += "\n" + getStrForTemp(_loc2_,"selfchess.upgradeBtn.nextTip");
            }
            upBtn.tipData = _loc4_;
            if(_loc6_.winCount >= 0)
            {
               _winStateImg.setFrame(1);
            }
            else
            {
               _winStateImg.setFrame(2);
               _winTxt.text = "" + Math.abs(_loc6_.winCount);
            }
            _loc1_ = _currGold / 10 > 5 ? 5 : _currGold / 10;
            _tipContainer.tipData = LanguageMgr.GetTranslation("selfchess.point.addTip",_loc1_);
         }
      }
      
      private function getStrForTemp(param1:UpgradeTemplateInfo, param2:String) : String
      {
         var _loc3_:Array = param1.TemplateName.split(",");
         return LanguageMgr.GetTranslation(param2,_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4]);
      }
      
      private function get model() : SelfChessModel
      {
         return SelfChessManager.Ins.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bleftBg);
         _bleftBg = null;
         ObjectUtils.disposeObject(_winTxt);
         _winTxt = null;
         ObjectUtils.disposeObject(_hasGoldTxt);
         _hasGoldTxt = null;
         ObjectUtils.disposeObject(_bleftLvTxt);
         _bleftLvTxt = null;
         ObjectUtils.disposeObject(_bLeftAddTxt);
         _bLeftAddTxt = null;
         ObjectUtils.disposeObject(_bleftGoldTxt);
         _bleftGoldTxt = null;
         ObjectUtils.disposeObject(upBtn);
         upBtn = null;
         ObjectUtils.disposeObject(progress);
         progress = null;
         ObjectUtils.disposeObject(_winStateImg);
         _winStateImg = null;
         ObjectUtils.disposeAllChildren(_tipContainer);
         ObjectUtils.disposeObject(_tipContainer);
         _tipContainer = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

