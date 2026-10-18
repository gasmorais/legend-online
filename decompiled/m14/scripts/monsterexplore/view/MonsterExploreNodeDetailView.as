package monsterexplore.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import monsterexplore.MonsterSweepFrame;
   import mvc.module.monsterexplore.MonsterExploreModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.MonsterExploreTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.MonsterExploreManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class MonsterExploreNodeDetailView extends Component
   {
      
      private var _back:MovieClip;
      
      private var _mapIcon:BaseIconView;
      
      private var _mapMask:ScaleBitmapImage;
      
      private var _nameBack:Bitmap;
      
      private var _nameText:GradientText;
      
      private var _rewardView:MonsterExploreBossRewardView;
      
      private var _enterBtn:IconButton;
      
      private var _checkFallGoodsBtn:TextButton;
      
      private var _info9CornerBg:Scale9CornerImage;
      
      private var _closeBtn:BaseButton;
      
      private var _data:MonsterExploreTempInfo;
      
      private var _mopupBtn:BaseButton;
      
      public function MonsterExploreNodeDetailView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatCustomObject("MonsterExploreNodeDetailView.CampaignInfoBackMc");
         _mapIcon = ComponentFactory.Instance.creatCustomObject("MonsterExploreNodeDetailView.MapIcon",[loadComplete]);
         _nameBack = ComponentFactory.Instance.creatBitmap("asset.MonsterExploreNodeDetailView.nameBack");
         _mapMask = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreNodeDetailView.mapMask");
         _info9CornerBg = ComponentFactory.Instance.creatComponentByStylename("core.CampaignInfoView.9CornerBg");
         _enterBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreNodeDetailView.enterBtn");
         _checkFallGoodsBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreNodeDetailView.checkFallGoodsBtn");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreNodeDetailView.CloseBtn");
         _rewardView = ComponentFactory.Instance.creatCustomObject("MonsterExploreNodeDetailView.rewardView");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreNodeDetailView.nameText");
         _mopupBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreNodeDetailView.MopupBtn");
         addChild(_rewardView);
         addChild(_back);
         addChild(_info9CornerBg);
         addChild(_mapIcon);
         addChild(_mapMask);
         addChild(_nameBack);
         addChild(_nameText);
         addChild(_enterBtn);
         addChild(_checkFallGoodsBtn);
         addChild(_closeBtn);
         addChild(_mopupBtn);
         _mopupBtn.visible = false;
         _checkFallGoodsBtn.text = LanguageMgr.GetTranslation("selectcampaign.view.CampaignInfoView.checkFallGoodsBtn.text");
         _rewardView.visible = false;
      }
      
      private function addEvent() : void
      {
         _enterBtn.addEventListener("click",__enterClickHandler);
         _checkFallGoodsBtn.addEventListener("click",__checkFallGoodsHandler);
         _closeBtn.addEventListener("click",__onCloseBtnClick);
         _mopupBtn.addEventListener("click",__mopupBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_enterBtn)
         {
            _enterBtn.removeEventListener("click",__enterClickHandler);
         }
         if(_checkFallGoodsBtn)
         {
            _checkFallGoodsBtn.removeEventListener("click",__checkFallGoodsHandler);
         }
         if(_closeBtn)
         {
            _closeBtn.removeEventListener("click",__onCloseBtnClick);
         }
         if(_mopupBtn)
         {
            _mopupBtn.removeEventListener("click",__mopupBtnClickHandler);
         }
      }
      
      private function __mopupBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = int(ConfigInfoManager.instance.getMonsterExploreBossMaxCount());
         var _loc3_:int = _loc2_ - exploreModel.bossHasCount;
         if(_loc3_ <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MonsterExploreNodeDetailView.leftCount.text"));
            return;
         }
         var _loc4_:MonsterSweepFrame = ComponentFactory.Instance.creatComponentByStylename("core.MonsterSweepFrame");
         _loc4_.data = {
            "num":_loc3_,
            "ChapterId":data.ChapterId,
            "NodeId":data.NodeId
         };
         _loc4_.show();
      }
      
      private function __alertBackHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.openControllerByInfo("kingcontract");
         }
      }
      
      private function mopupCallBack() : void
      {
      }
      
      protected function __onCloseBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         this.visible = false;
      }
      
      private function __checkFallGoodsHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _rewardView.visible = !_rewardView.visible;
      }
      
      private function __enterClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!data)
         {
            return;
         }
         if(data.ChapterId == exploreModel.curChapterId && data.NodeId == exploreModel.curNodeId)
         {
            MsgMan.notifyObserver("EXPLORE_NODE_CHANGE");
            return;
         }
         if(!canFight)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("demonland.main.text3"));
            return;
         }
         MonsterExploreManager.instance.sendChapterNodeSelect(data.ChapterId,data.NodeId);
         MsgMan.notifyObserver("EXPLORE_NODE_CHANGE");
      }
      
      private function get canFight() : Boolean
      {
         if(data.ChapterId > exploreModel.maxChapterId || data.ChapterId == exploreModel.maxChapterId && data.NodeId > exploreModel.maxNodeId + 1)
         {
            return false;
         }
         return true;
      }
      
      private function get canMopup() : Boolean
      {
         if(data.ChapterId > exploreModel.maxChapterId || data.ChapterId == exploreModel.maxChapterId && data.NodeId > exploreModel.maxNodeId)
         {
            return false;
         }
         return true;
      }
      
      private function loadComplete(param1:BaseIconView = null) : void
      {
         (_mapIcon.content as Bitmap).smoothing = false;
      }
      
      public function get data() : MonsterExploreTempInfo
      {
         return _data;
      }
      
      public function set data(param1:MonsterExploreTempInfo) : void
      {
         var _loc2_:Array = null;
         _data = param1;
         if(data)
         {
            this.visible = true;
            _nameText.text = data.NodeName;
            _mapIcon.icon = PathManager.mapInstanceBigIconPath(int(data.NodeMapPath));
            _loc2_ = TempleteManager.instance.monsterExploreDropTempCate.getTemplatesByDropId(data.BossDrop);
            if(_loc2_)
            {
               _rewardView.data = _loc2_;
            }
            _enterBtn.enable = canFight;
            _mopupBtn.visible = canMopup;
         }
         else
         {
            this.visible = false;
         }
      }
      
      public function tipsGotoFrame(param1:int) : void
      {
         _back.gotoAndStop(param1);
      }
      
      private function get exploreModel() : MonsterExploreModel
      {
         return MonsterExploreManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeViolentMc(_back);
         _back = null;
         ObjectUtils.disposeObject(_enterBtn);
         _enterBtn = null;
         ObjectUtils.disposeObject(_checkFallGoodsBtn);
         _checkFallGoodsBtn = null;
         ObjectUtils.disposeObject(_info9CornerBg);
         _info9CornerBg = null;
         ObjectUtils.disposeObject(_closeBtn);
         _closeBtn = null;
         ObjectUtils.disposeObject(_mapIcon);
         _mapIcon = null;
         ObjectUtils.disposeObject(_mapMask);
         _mapMask = null;
         ObjectUtils.disposeObject(_nameBack);
         _nameBack = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_rewardView);
         _rewardView = null;
         ObjectUtils.disposeObject(_mopupBtn);
         _mopupBtn = null;
         super.dispose();
      }
   }
}

