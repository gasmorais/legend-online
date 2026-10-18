package raveparty
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconTextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.RavePartyManager;
   import mvc.module.raveparty.RavePartyModel;
   import raveparty.sort.RavePartyScoreSortView;
   import yishi.utils.MsgMan;
   
   public class RavePartyFrame extends Frame implements IManualSize
   {
      
      private var border:ScaleBitmapImage;
      
      private var rightBack:Bitmap;
      
      private var activeTimeText:FilterFrameText;
      
      private var btnVbox:VBox;
      
      private var raveBtn:SelectedIconTextButton;
      
      private var selfBtn:SelectedIconTextButton;
      
      private var guildBtn:SelectedIconTextButton;
      
      private var serverBtn:SelectedIconTextButton;
      
      private var guildCrossBtn:SelectedIconTextButton;
      
      private var serverCrossBtn:SelectedIconTextButton;
      
      private var btnGroup:SelectedButtonGroup;
      
      private var raveView:RavePartyView;
      
      private var scoreView:RavePartyScoreView;
      
      private var sortView:RavePartyScoreSortView;
      
      public function RavePartyFrame()
      {
         super();
         initView();
         addEvent();
         btnGroup.selectIndex = 0;
         refreshView();
         RavePartyManager.instance.sendRavePartyRequest(1);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,870,615);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         border = ComponentFactory.Instance.creatComponentByStylename("RavePartyFrame.border");
         rightBack = ComponentFactory.Instance.creatBitmap("asset.RavePartyFrame.rightBack");
         activeTimeText = ComponentFactory.Instance.creatComponentByStylename("RavePartyFrame.activeTimeText");
         btnVbox = ComponentFactory.Instance.creatComponentByStylename("RavePartyFrame.btnVbox");
         raveBtn = ComponentFactory.Instance.creatComponentByStylename("RavePartyFrame.raveBtn");
         selfBtn = ComponentFactory.Instance.creatComponentByStylename("RavePartyFrame.selfBtn");
         guildBtn = ComponentFactory.Instance.creatComponentByStylename("RavePartyFrame.guildBtn");
         serverBtn = ComponentFactory.Instance.creatComponentByStylename("RavePartyFrame.serverBtn");
         guildCrossBtn = ComponentFactory.Instance.creatComponentByStylename("RavePartyFrame.guildCrossBtn");
         serverCrossBtn = ComponentFactory.Instance.creatComponentByStylename("RavePartyFrame.serverCrossBtn");
         addToContent(border);
         addToContent(rightBack);
         addToContent(activeTimeText);
         addToContent(btnVbox);
         btnVbox.addChild(raveBtn);
         btnVbox.addChild(selfBtn);
         btnVbox.addChild(guildBtn);
         btnVbox.addChild(serverBtn);
         btnVbox.addChild(guildCrossBtn);
         btnVbox.addChild(serverCrossBtn);
         btnGroup = new SelectedButtonGroup();
         btnGroup.addSelectItem(raveBtn);
         btnGroup.addSelectItem(selfBtn);
         btnGroup.addSelectItem(guildBtn);
         btnGroup.addSelectItem(serverBtn);
         btnGroup.addSelectItem(guildCrossBtn);
         btnGroup.addSelectItem(serverCrossBtn);
         raveBtn.text = LanguageMgr.GetTranslation("ui.toptoolbar.TopToolsBar.tipData_raveparty");
         selfBtn.text = LanguageMgr.GetTranslation("RavePartyFrame.selfBtn.text");
         guildBtn.text = LanguageMgr.GetTranslation("RavePartyScoreSortFrame.scoreText.text7");
         serverBtn.text = LanguageMgr.GetTranslation("RavePartyScoreSortFrame.scoreText.text8");
         guildCrossBtn.text = LanguageMgr.GetTranslation("RavePartyScoreSortFrame.scoreText.text9");
         serverCrossBtn.text = LanguageMgr.GetTranslation("RavePartyScoreSortFrame.scoreText.text10");
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         btnGroup.addEventListener("change",__selectedBtnHandler);
         MsgMan.addObserver("RAVE_PARTY_TEMP_UPDTAE",this,__updateRavePartyTimeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         btnGroup.removeEventListener("change",__selectedBtnHandler);
         MsgMan.removeObserver("RAVE_PARTY_TEMP_UPDTAE",this,__updateRavePartyTimeHandler);
      }
      
      private function __updateRavePartyTimeHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         activeTimeText.text = LanguageMgr.GetTranslation("godarrive.GodArriveFrame.activeTime",model.openTime,model.stopTime);
      }
      
      private function __selectedBtnHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         clearView();
         var _loc2_:ISelectable = btnGroup.getSelectedItem();
         if(btnGroup.selectIndex == 0)
         {
            if(!raveView)
            {
               raveView = ComponentFactory.Instance.creatCustomObject("RavePartyFrame.raveView");
            }
            if(!raveView.parent)
            {
               addToContent(raveView);
            }
         }
         else if(btnGroup.selectIndex == 1 || btnGroup.selectIndex == 2 || btnGroup.selectIndex == 3)
         {
            if(!scoreView)
            {
               scoreView = ComponentFactory.Instance.creatCustomObject("RavePartyFrame.scoreView");
            }
            scoreView.setShowType(btnGroup.selectIndex + 3);
            if(!scoreView.parent)
            {
               addToContent(scoreView);
            }
         }
         else if(btnGroup.selectIndex == 4 || btnGroup.selectIndex == 5)
         {
            if(!sortView)
            {
               sortView = ComponentFactory.Instance.creatCustomObject("RavePartyFrame.sortView",[btnGroup.selectIndex + 1 + 2]);
            }
            if(!sortView.parent)
            {
               addToContent(sortView);
            }
         }
      }
      
      private function clearView() : void
      {
         ObjectUtils.disposeObject(scoreView);
         scoreView = null;
         ObjectUtils.disposeObject(raveView);
         raveView = null;
         ObjectUtils.disposeObject(sortView);
         sortView = null;
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
         this.titleText = LanguageMgr.GetTranslation("ui.toptoolbar.TopToolsBar.tipData_raveparty");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get model() : RavePartyModel
      {
         return RavePartyManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(border)
         {
            ObjectUtils.disposeObject(border);
         }
         border = null;
         if(rightBack)
         {
            ObjectUtils.disposeObject(rightBack);
         }
         rightBack = null;
         if(activeTimeText)
         {
            ObjectUtils.disposeObject(activeTimeText);
         }
         activeTimeText = null;
         if(raveBtn)
         {
            ObjectUtils.disposeObject(raveBtn);
         }
         raveBtn = null;
         if(selfBtn)
         {
            ObjectUtils.disposeObject(selfBtn);
         }
         selfBtn = null;
         if(guildBtn)
         {
            ObjectUtils.disposeObject(guildBtn);
         }
         guildBtn = null;
         if(serverBtn)
         {
            ObjectUtils.disposeObject(serverBtn);
         }
         serverBtn = null;
         if(guildCrossBtn)
         {
            ObjectUtils.disposeObject(guildCrossBtn);
         }
         guildCrossBtn = null;
         if(serverCrossBtn)
         {
            ObjectUtils.disposeObject(serverCrossBtn);
         }
         serverCrossBtn = null;
         if(btnVbox)
         {
            ObjectUtils.disposeObject(btnVbox);
         }
         btnVbox = null;
         if(btnGroup)
         {
            btnGroup.dispose();
         }
         btnGroup = null;
         if(scoreView)
         {
            ObjectUtils.disposeObject(scoreView);
         }
         scoreView = null;
         if(sortView)
         {
            ObjectUtils.disposeObject(sortView);
         }
         sortView = null;
         if(raveView)
         {
            ObjectUtils.disposeObject(raveView);
         }
         raveView = null;
         super.dispose();
      }
   }
}

