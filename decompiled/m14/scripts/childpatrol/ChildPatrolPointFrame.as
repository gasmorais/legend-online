package childpatrol
{
   import childpve.ChildPveSkillItemView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import mainBar.effects.MainToolBtnGlowEffect;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.controler.ChildPveController;
   import mvc.module.armyII.SkillInfo;
   import mvc.module.childpatrol.ChildPatrolTowerInfo;
   import mvc.module.children.ChildData;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ChildPveBossTempInfo;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.GuardPveExploreRewardInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildPatrolPointFrame extends Frame
   {
      
      private var _back:MutipleImage;
      
      private var _formBtn:IconButton;
      
      private var _normalBackBox:HBox;
      
      private var _normalRewardBox:HBox;
      
      private var _hardbackBox:HBox;
      
      private var _hardRewardBox:HBox;
      
      private var _entrance:ChildPointBossItem;
      
      private var _challege:Image;
      
      private var _disEffect:MainToolBtnGlowEffect;
      
      private var _skillTitleContainer:SimpleTileList;
      
      private var _controller:ChildPveController;
      
      private var _data:ChildPatrolTowerInfo;
      
      public function ChildPatrolPointFrame()
      {
         super();
      }
      
      private function refreshView() : void
      {
         initView();
         initBossView();
         initSkillView();
         initEvent();
      }
      
      private function initView() : void
      {
         _controller = FrameControllerManager.instance.childPveController;
         _controller.model.setfirstChild(_controller.model.firstChildId);
         titleText = LanguageMgr.GetTranslation("childpve.point.title");
         _back = ComponentFactory.Instance.creatComponentByStylename("childpve.pointFrameBack");
         _formBtn = ComponentFactory.Instance.creatComponentByStylename("childpve.pointFormBtn");
         _skillTitleContainer = ComponentFactory.Instance.creatComponentByStylename("childpve.pointSkillTitle",[5]);
         _normalBackBox = ComponentFactory.Instance.creatCustomObject("childpve.point.normalRewardBackBox");
         _normalRewardBox = ComponentFactory.Instance.creatCustomObject("childpve.point.normalRewardBox");
         _hardbackBox = ComponentFactory.Instance.creatCustomObject("childpve.point.advanceRewardBackBox");
         _hardRewardBox = ComponentFactory.Instance.creatCustomObject("childpve.point.advanceRewardBox");
         addToContent(_back);
         addToContent(_normalBackBox);
         addToContent(_normalRewardBox);
         addToContent(_hardbackBox);
         addToContent(_hardRewardBox);
         addToContent(_skillTitleContainer);
         addToContent(_formBtn);
      }
      
      private function initBossView() : void
      {
         var _loc1_:ChildPveBossTempInfo = null;
         if(_data != null)
         {
            _entrance = new ChildPointBossItem();
            _entrance.data = _data;
            addToContent(_entrance);
            _challege = ComponentFactory.Instance.creatComponentByStylename("childpve.point.challege");
            addToContent(_challege);
            _challege.mouseEnabled = false;
            _challege.buttonMode = true;
            _challege.filters = [UIFilter.getGrayFilter()];
            if(_data.bossState == 0)
            {
               _disEffect = new MainToolBtnGlowEffect(_challege);
               _disEffect.play();
               _challege.mouseEnabled = true;
               _challege.filters = null;
            }
            _loc1_ = TempleteManager.instance.childPveBossTemplateCate.getTemplateById(_data.bossId);
            initNormalRewards(_loc1_);
            initAdvanceRewards();
         }
      }
      
      private function initSkillView() : void
      {
         var _loc4_:ChildPveSkillItemView = null;
         var _loc1_:SkillInfo = null;
         var _loc3_:int = 0;
         var _loc2_:Vector.<SkillTempInfo> = _controller.getBossAndSkillFromTemp();
         _skillTitleContainer.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = new SkillInfo();
            _loc4_ = new ChildPveSkillItemView();
            _loc1_.templateId = _loc2_[_loc3_].TemplateId;
            if(_controller.pveModel.skillInfo.indexOf(_loc1_.templateId + "") > -1)
            {
               _loc1_.grade = 1;
            }
            _loc4_.data = _loc1_;
            _skillTitleContainer.addChild(_loc4_);
            _loc3_++;
         }
         _skillTitleContainer.commitChanges();
      }
      
      private function initBackBox(param1:HBox) : void
      {
         var _loc3_:Bitmap = null;
         var _loc2_:int = 0;
         param1.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc3_ = ComponentFactory.Instance.creatBitmap("asset.childpve.rewardBack");
            param1.addChild(_loc3_);
            _loc2_++;
         }
         param1.commitChanges();
      }
      
      private function initNormalRewards(param1:ChildPveBossTempInfo) : void
      {
         var _loc3_:Array = null;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:BaseItemView = null;
         var _loc5_:Array = null;
         var _loc8_:GoodsInfo = null;
         var _loc7_:int = 0;
         initBackBox(_normalBackBox);
         if(param1 != null && param1.dropItems != null)
         {
            _loc3_ = param1.dropItems.split("|");
            _normalRewardBox.beginChanges();
            while(_loc7_ < _loc3_.length)
            {
               _loc4_ = ComponentFactory.Instance.creatCustomObject("ChildPatrolTaskView.baseItem");
               _loc5_ = String(_loc3_[_loc7_]).split(",");
               _loc2_ = int(_loc5_[0]);
               _loc6_ = int(_loc5_[1]);
               _loc8_ = new GoodsInfo();
               _loc8_.templateId = _loc2_;
               _loc8_.count = _loc6_;
               _loc4_.data = _loc8_;
               _normalRewardBox.addChild(_loc4_);
               _loc7_++;
            }
            _normalRewardBox.commitChanges();
         }
      }
      
      private function initAdvanceRewards() : void
      {
         var _loc8_:ChildTempInfo = null;
         var _loc4_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:GuardPveExploreRewardInfo = null;
         var _loc1_:BaseItemView = null;
         var _loc7_:GoodsInfo = null;
         var _loc5_:int = 0;
         initBackBox(_hardbackBox);
         var _loc6_:ChildData = ChildManager.instance.model.getChildById(_data.exploreChildId);
         if(_loc6_ != null)
         {
            _loc8_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_loc6_.job,_loc6_.growthGrade);
            if(_loc8_ != null)
            {
               _loc4_ = TempleteManager.instance.guardPveExploreTemplateCate.getDropList(_loc8_.MasterType,_loc6_.growthGrade);
               _loc2_ = int(_loc4_ == null ? 0 : _loc4_.length);
               _hardRewardBox.beginChanges();
               while(_loc5_ < _loc2_)
               {
                  _loc1_ = ComponentFactory.Instance.creatCustomObject("ChildPatrolTaskView.baseItem");
                  _loc3_ = _loc4_[_loc5_];
                  _loc7_ = new GoodsInfo();
                  _loc7_.templateId = _loc3_.itemId;
                  _loc7_.count = _loc3_.count;
                  _loc1_.data = _loc7_;
                  _hardRewardBox.addChild(_loc1_);
                  _loc5_++;
               }
               _hardRewardBox.commitChanges();
            }
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _formBtn.addEventListener("click",formHandler);
         _challege.addEventListener("click",challegeBtnClickHandle);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_formBtn)
         {
            _formBtn.removeEventListener("click",formHandler);
         }
         if(_challege)
         {
            _challege.removeEventListener("click",challegeBtnClickHandle);
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
      
      private function challegeBtnClickHandle(param1:MouseEvent) : void
      {
         if(_controller.model.getFightChildCount() == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("managers.ChildManager.pickChildTips"));
            return;
         }
         _controller.sendFight(_data.towerId);
      }
      
      private function formHandler(param1:MouseEvent) : void
      {
         if(_controller.model.childList.length == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("managers.ChildManager.pickChildTips"));
            return;
         }
         SoundManager.instance.play("022");
         _controller.openFormationFrame();
      }
      
      public function set data(param1:ChildPatrolTowerInfo) : void
      {
         _data = param1 as ChildPatrolTowerInfo;
         if(_data != null)
         {
            refreshView();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_disEffect != null)
         {
            _disEffect.dispose();
         }
         _disEffect = null;
         ObjectUtils.disposeObject(_normalRewardBox);
         _normalRewardBox = null;
         ObjectUtils.disposeObject(_hardRewardBox);
         _hardRewardBox = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_skillTitleContainer);
         _skillTitleContainer = null;
         ObjectUtils.disposeObject(_formBtn);
         _formBtn = null;
         ObjectUtils.disposeObject(_challege);
         _challege = null;
         ObjectUtils.disposeObject(_entrance);
         _entrance = null;
         ObjectUtils.disposeObject(_normalBackBox);
         _normalBackBox = null;
         ObjectUtils.disposeObject(_hardbackBox);
         _hardbackBox = null;
         _controller = null;
         _data = null;
         super.dispose();
      }
   }
}

