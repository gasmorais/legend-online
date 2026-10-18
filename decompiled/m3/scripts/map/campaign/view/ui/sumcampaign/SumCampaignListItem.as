package map.campaign.view.ui.sumcampaign
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.sumpassion.TaskMsg;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.NotificationManager;
   
   public class SumCampaignListItem extends Component
   {
      
      private var _taskMsg:TaskMsg;
      
      private var _back1:Scale9CornerImage;
      
      private var _taskNote:FilterFrameText;
      
      private var _title:FilterFrameText;
      
      private var _hbox:HBox;
      
      private var _icon:ScaleFrameImage;
      
      private var _boxName:FilterFrameText;
      
      private var _line:ScaleBitmapImage;
      
      public function SumCampaignListItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back1 = ComponentFactory.Instance.creatComponentByStylename("sumCampaign.ItemBack1");
         _taskNote = ComponentFactory.Instance.creatComponentByStylename("sumCampaign.ItemNoteTxt");
         _title = ComponentFactory.Instance.creatComponentByStylename("sumCampaign.ItemDescribeTxt");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("sumCampaign.TargetHbox");
         _icon = ComponentFactory.Instance.creatComponentByStylename("sumCampaign.ItemTitleIcon");
         _boxName = ComponentFactory.Instance.creatComponentByStylename("sumCampaign.boxNameTxt");
         _line = ComponentFactory.Instance.creatComponentByStylename("sumCampaign.TargetLine");
         addChild(_back1);
         addChild(_taskNote);
         addChild(_title);
         addChild(_hbox);
         addChild(_line);
         _hbox.addChild(_icon);
         _hbox.addChild(_boxName);
         _taskNote.text = LanguageMgr.GetTranslation("sumcampaign.SumCampaignListItem.noteTxt");
         _icon.setFrame(1);
         _back1.visible = false;
         _back1.mouseChildren = false;
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
         NotificationManager.instance.addEventListener("PUBLIC_GIFT_UPDATE",__updateViewHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
         NotificationManager.instance.removeEventListener("PUBLIC_GIFT_UPDATE",__updateViewHandler);
      }
      
      private function __updateViewHandler(param1:NotificationEvent) : void
      {
         data = _taskMsg;
      }
      
      public function set data(param1:TaskMsg) : void
      {
         _taskMsg = param1;
         _icon.setFrame(param1.taskType);
         _title.text = LanguageMgr.GetTranslation("sumcampaign.SumCampaignListItem.titleTxt" + param1.taskType,param1.killCount,param1.needKillCount);
         _boxName.text = LanguageMgr.GetTranslation("sumcampaign.SumCampaignListItem.boxNameTxt" + param1.taskType);
         this.tipData = param1;
         if(_taskMsg.isSendReward)
         {
            this.filters = [UIFilter.getGrayFilter()];
         }
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         _back1.visible = true;
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         _back1.visible = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back1);
         _back1 = null;
         ObjectUtils.disposeObject(_taskNote);
         _taskNote = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_boxName);
         _boxName = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         _taskMsg = null;
         super.dispose();
      }
   }
}

