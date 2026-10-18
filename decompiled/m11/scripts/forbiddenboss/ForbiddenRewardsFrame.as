package forbiddenboss
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.forbiddenboss.ForbiddenBossModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.ForbiddenBossTempInfo;
   import yishi.manager.ForbiddenBossManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   
   public class ForbiddenRewardsFrame extends Frame implements IManualSize
   {
      
      private var _rewardssSpanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      public function ForbiddenRewardsFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,780,548);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("forbiddenRewardsFrame.titleText");
         _rewardssSpanel = ComponentFactory.Instance.creatComponentByStylename("forbiddenRewardsFrame.rewardsSpanel");
         _vBox = ComponentFactory.Instance.creatCustomObject("forbiddenRewardsFrame.vBox");
         addToContent(_rewardssSpanel);
         _rewardssSpanel.setView(_vBox);
         refreshView();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("FORBIDDEN_BOSS_USER_UPDATE",this,__updateUserHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("FORBIDDEN_BOSS_USER_UPDATE",this,__updateUserHandler);
      }
      
      private function __updateUserHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      public function refreshView() : void
      {
         var _loc1_:ForbiddenRewardsItem = null;
         var _loc2_:int = 0;
         _vBox.removeAllChild();
         _vBox.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < infoArr.length)
         {
            _loc1_ = new ForbiddenRewardsItem();
            _loc1_.data = infoArr[_loc2_];
            _vBox.addChild(_loc1_);
            _loc2_++;
         }
         _vBox.commitChanges();
         _rewardssSpanel.invalidateViewport();
      }
      
      private function get infoArr() : Array
      {
         var _loc3_:Dictionary = TempleteManager.instance.forbiddenBossTempCate.getTemplates();
         var _loc1_:Array = [];
         for each(var _loc2_:ForbiddenBossTempInfo in _loc3_)
         {
            if(model.firstRewardDic[_loc2_.Id])
            {
               _loc2_.firstRewardsType = model.firstRewardDic[_loc2_.Id];
            }
            _loc1_.push(_loc2_);
         }
         _loc1_.sort(sortById);
         return _loc1_;
      }
      
      private function sortById(param1:ForbiddenBossTempInfo, param2:ForbiddenBossTempInfo) : int
      {
         if(param1.firstRewardsType < param2.firstRewardsType)
         {
            return -1;
         }
         if(param1.firstRewardsType > param2.firstRewardsType)
         {
            return 1;
         }
         if(param1.Id < param2.Id)
         {
            return -1;
         }
         if(param1.Id > param2.Id)
         {
            return 1;
         }
         return 0;
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get model() : ForbiddenBossModel
      {
         return ForbiddenBossManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_rewardssSpanel);
         _rewardssSpanel = null;
         super.dispose();
      }
   }
}

