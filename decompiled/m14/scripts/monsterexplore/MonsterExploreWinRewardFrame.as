package monsterexplore
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.module.monsterexplore.MonsterExploreModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.MonsterExploreTempInfo;
   import yishi.manager.MonsterExploreManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseItemView;
   
   public class MonsterExploreWinRewardFrame extends Frame
   {
      
      private var _mainBack:Bitmap;
      
      private var _chapterText:GradientText;
      
      private var _rewardHbox:HBox;
      
      private var _nextBtn:IconButton;
      
      private var tempInfo:MonsterExploreTempInfo;
      
      private var _confirmBtn:BaseButton;
      
      private var nodeName:String = "";
      
      private var _bagPanel:ScrollPanel;
      
      public function MonsterExploreWinRewardFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _mainBack = ComponentFactory.Instance.creatBitmap("asset.MonsterExploreWinRewardFrame.mainBack");
         _chapterText = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreWinRewardFrame.chapterText");
         _rewardHbox = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreWinRewardFrame.rewardHbox");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreWinRewardFrame.nextBtn");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("core.AlertConfirmBtn_3");
         addToContent(_mainBack);
         addToContent(_chapterText);
         addToContent(_rewardHbox);
         addToContent(_nextBtn);
         addToContent(_confirmBtn);
         _bagPanel = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreWinRewardFrame.rewardHboxPanel");
         _bagPanel.setView(_rewardHbox);
         addToContent(_bagPanel);
         _confirmBtn.visible = false;
         _confirmBtn.x = 162;
         _confirmBtn.y = 205;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _nextBtn.addEventListener("click",__onNextClickHandler);
         _confirmBtn.addEventListener("click",__confirmBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__onNextClickHandler);
         }
         if(_confirmBtn)
         {
            _confirmBtn.removeEventListener("click",__confirmBtnClickHandler);
         }
      }
      
      private function __confirmBtnClickHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function __onNextClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:MonsterExploreTempInfo = getNextData();
         if(_loc2_ == null)
         {
            return;
         }
         MonsterExploreManager.instance.sendChapterNodeSelect(_loc2_.ChapterId,_loc2_.NodeId);
         dispose();
      }
      
      private function refreshView() : void
      {
         var _loc4_:int = 0;
         var _loc1_:BaseItemView = null;
         var _loc2_:Array = null;
         var _loc5_:GoodsInfo = null;
         tempInfo = TempleteManager.instance.monsterExploreTemplateCate.getTemplateByChapterAndNode(exploreModel.curChapterId,exploreModel.curNodeId);
         if(!tempInfo)
         {
            return;
         }
         _chapterText.text = tempInfo.NodeName;
         _nextBtn.enable = getNextData() != null;
         _rewardHbox.removeAllChild();
         if(StringHelper.isNullOrEmpty(exploreModel.bossWinReward))
         {
            return;
         }
         var _loc3_:Array = exploreModel.bossWinReward.split("|");
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("MonsterExploreWinRewardFrame.rewardItem");
            _loc2_ = _loc3_[_loc4_].split(",");
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = _loc2_[0];
            _loc5_.count = _loc2_[1];
            _loc1_.data = _loc5_;
            _rewardHbox.addChild(_loc1_);
            _loc4_++;
         }
         _bagPanel.invalidateViewport();
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
      
      private function getNextData() : MonsterExploreTempInfo
      {
         var _loc2_:int = exploreModel.curNodeId + 1;
         var _loc3_:int = exploreModel.curChapterId + 1;
         var _loc1_:MonsterExploreTempInfo = TempleteManager.instance.monsterExploreTemplateCate.getTemplateByChapterAndNode(exploreModel.curChapterId,_loc2_);
         if(!_loc1_)
         {
            _loc1_ = TempleteManager.instance.monsterExploreTemplateCate.getTemplateByChapterAndNode(_loc3_,1);
            if(!_loc1_)
            {
               return null;
            }
            return _loc1_;
         }
         return _loc1_;
      }
      
      private function get exploreModel() : MonsterExploreModel
      {
         return MonsterExploreManager.instance.model;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         this.titleText = LanguageMgr.GetTranslation("MonsterExploreWinRewardFrame.title.text");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         if(param1 && param1.frameData)
         {
            if(param1.frameData is String)
            {
               _confirmBtn.visible = true;
               _nextBtn.visible = false;
               _chapterText.text = String(param1.frameData);
            }
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bagPanel);
         _bagPanel = null;
         exploreModel.bossWinReward = null;
         ObjectUtils.disposeObject(_mainBack);
         _mainBack = null;
         ObjectUtils.disposeObject(_chapterText);
         _chapterText = null;
         ObjectUtils.disposeObject(_rewardHbox);
         _rewardHbox = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         super.dispose();
      }
   }
}

