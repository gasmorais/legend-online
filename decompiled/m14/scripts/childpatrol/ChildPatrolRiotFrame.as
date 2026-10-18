package childpatrol
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ChildPatrolEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildPatrolManager;
   import mvc.module.childpatrol.ChildPatrolModel;
   import mvc.module.childpatrol.ChildPatrolTowerInfo;
   import mvc.module.children.ChildData;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildPatrolRiotFrame extends Frame
   {
      
      private var back:MutipleImage;
      
      private var leftView:ChildPatrolLeftListView;
      
      private var riotTitleText:FilterFrameText;
      
      private var descText:FilterFrameText;
      
      private var headIcon:BaseIconView;
      
      private var patrolBtn:IconButton;
      
      private var leftCountText:FilterFrameText;
      
      private var patrolChildData:ChildData;
      
      private var _data:ChildPatrolTowerInfo;
      
      private var helpConfigInfo:ConfigInfosTempInfo;
      
      private var maxCount:int;
      
      private var leftCount:int;
      
      public function ChildPatrolRiotFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolRiotFrame.back");
         leftView = ComponentFactory.Instance.creatCustomObject("ChildPatrolTowerFrame.leftView");
         riotTitleText = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolRiotFrame.riotTitleText");
         descText = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolRiotFrame.descText");
         patrolBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolRiotFrame.patrolBtn");
         leftCountText = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolRiotFrame.leftCountText");
         addToContent(back);
         addToContent(leftView);
         addToContent(riotTitleText);
         addToContent(descText);
         addToContent(patrolBtn);
         addToContent(leftCountText);
         helpConfigInfo = TempleteManager.instance.getConfigInfoByConfigName("child_patrol_max_help_count");
         if(helpConfigInfo)
         {
            maxCount = parseInt(helpConfigInfo.ConfigValue);
         }
         riotTitleText.text = LanguageMgr.GetTranslation("ChildPatrolRiotFrame.riotTitleText.text");
         descText.text = LanguageMgr.GetTranslation("ChildPatrolRiotFrame.descText.text");
         leftView.frameType = ChildFunType.REVOLT;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         patrolBtn.addEventListener("click",__patrolClickHandler);
         ChildPatrolManager.instance.addEventListener("SELECT_ADD_CHILDPATROL",__addChildToListHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         patrolBtn.removeEventListener("click",__patrolClickHandler);
         ChildPatrolManager.instance.removeEventListener("SELECT_ADD_CHILDPATROL",__addChildToListHandler);
         if(headIcon)
         {
            headIcon.removeEventListener("click",__removeChildFromListHandler);
         }
      }
      
      public function set data(param1:ChildPatrolTowerInfo) : void
      {
         _data = param1;
         leftCount = maxCount - model.hasHelpCount;
         leftCountText.text = LanguageMgr.GetTranslation("ChildPatrolRiotFrame.leftCountText.text",leftCount,maxCount);
      }
      
      private function __patrolClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!_data)
         {
            return;
         }
         if(!patrolChildData)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildPatrolBottomView.tower.noChilds.alert"));
            return;
         }
         if(model.hasHelpCount >= maxCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildPatrolRiotFrame.help.noCount"));
            return;
         }
         ChildPatrolManager.instance.sendChildPatrolOperate(8,model.curUserId,0,_data.towerId,[patrolChildData.childId]);
         dispose();
      }
      
      private function __addChildToListHandler(param1:ChildPatrolEvent) : void
      {
         patrolChildData = param1.data as ChildData;
         model.childIdList = [patrolChildData.childId];
         model.childList = [patrolChildData];
         headIcon = ComponentFactory.Instance.creatCustomObject("ChildPatrolRiotFrame.headIcon");
         headIcon.addEventListener("click",__removeChildFromListHandler);
         addToContent(headIcon);
         var _loc2_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(patrolChildData.job,patrolChildData.growthGrade);
         if(_loc2_)
         {
            headIcon.icon = PathManager.info.ResourcePath + "icon" + _loc2_.Icon;
            headIcon.buttonMode = true;
         }
      }
      
      private function __removeChildFromListHandler(param1:MouseEvent) : void
      {
         if(headIcon)
         {
            headIcon.removeEventListener("click",__removeChildFromListHandler);
            ObjectUtils.disposeObject(headIcon);
            headIcon = null;
            if(patrolChildData)
            {
               ChildPatrolManager.instance.sendDispatchEvent("SELECT_DEL_CHILDPATROL",patrolChildData);
            }
            patrolChildData = null;
            model.childIdList = [];
            model.childList = [];
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         titleText = LanguageMgr.GetTranslation("childpatrol.ChildPatrolRiotFrame.titleText");
      }
      
      private function get model() : ChildPatrolModel
      {
         return ChildPatrolManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(back)
         {
            ObjectUtils.disposeObject(back);
         }
         back = null;
         if(leftView)
         {
            ObjectUtils.disposeObject(leftView);
         }
         leftView = null;
         if(riotTitleText)
         {
            ObjectUtils.disposeObject(descText);
         }
         descText = null;
         if(back)
         {
            ObjectUtils.disposeObject(back);
         }
         back = null;
         if(patrolBtn)
         {
            ObjectUtils.disposeObject(patrolBtn);
         }
         patrolBtn = null;
         if(leftCountText)
         {
            ObjectUtils.disposeObject(leftCountText);
         }
         leftCountText = null;
         if(headIcon)
         {
            headIcon.removeEventListener("click",__removeChildFromListHandler);
            ObjectUtils.disposeObject(headIcon);
            headIcon = null;
         }
         patrolChildData = null;
         _data = null;
         helpConfigInfo = null;
         model.childIdList = [];
         model.childList = [];
         super.dispose();
      }
   }
}

