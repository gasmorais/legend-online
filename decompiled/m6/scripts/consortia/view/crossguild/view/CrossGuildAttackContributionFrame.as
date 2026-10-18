package consortia.view.crossguild.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.crossguild.CrossGuildModel;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.CrossGuildManager;
   import yishi.utils.MsgMan;
   
   public class CrossGuildAttackContributionFrame extends Frame implements IManualSize
   {
      
      private var _noRecordText:FilterFrameText;
      
      private var _border:ScaleBitmapImage;
      
      private var _titleBack:MutipleImage;
      
      private var _numTitleText:FilterFrameText;
      
      private var _infoTitleText:FilterFrameText;
      
      private var _contribuutionTitleText:FilterFrameText;
      
      private var _itemBox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      public function CrossGuildAttackContributionFrame()
      {
         super();
         initView();
         addEvent();
         CrossGuildManager.instance.sendFrameRequest(5);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,483,433);
      }
      
      private function initView() : void
      {
         _noRecordText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildAttackContributionFrame.noRecordText");
         _border = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildAttackContributionFrame.border");
         _itemBox = ComponentFactory.Instance.creatComponentByStylename("CrossGuildAttackContributionFrame.itemBox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("CrossGuildAttackContributionFrame.scrollPanel");
         _titleBack = ComponentFactory.Instance.creatComponentByStylename("CrossGuildAttackContributionFrame.titleBack");
         _contribuutionTitleText = ComponentFactory.Instance.creatComponentByStylename("CrossGuildAttackContributionFrame.contribuutionTitleText");
         _infoTitleText = ComponentFactory.Instance.creatComponentByStylename("CrossGuildAttackContributionFrame.infoTitleText");
         _numTitleText = ComponentFactory.Instance.creatComponentByStylename("CrossGuildAttackContributionFrame.numTitleText");
         addToContent(_border);
         addToContent(_titleBack);
         addToContent(_numTitleText);
         addToContent(_infoTitleText);
         addToContent(_contribuutionTitleText);
         addToContent(_noRecordText);
         addToContent(_scrollPanel);
         _scrollPanel.setView(_itemBox);
         _numTitleText.text = LanguageMgr.GetTranslation("colosseum.view.HeroRankFrame.rank");
         _infoTitleText.text = LanguageMgr.GetTranslation("CrossGuildDefendListView.infoTitleText.text");
         _contribuutionTitleText.text = LanguageMgr.GetTranslation("CrossGuildAttackContributionFrame.contribuutionTitleText.text");
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("MEMBER_ATTACK_CONTRIBUTION",this,__contributionBackHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("MEMBER_ATTACK_CONTRIBUTION",this,__contributionBackHandler);
      }
      
      private function __contributionBackHandler(param1:String, param2:Object) : void
      {
         refreshListView();
      }
      
      private function refreshListView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:CrossGuildMemberItem = null;
         _itemBox.removeAllChild();
         var _loc2_:int = int(model.attackContributionList.length);
         _loc3_ = 1;
         while(_loc3_ <= _loc2_)
         {
            _loc1_ = new CrossGuildMemberItem(_loc3_,2);
            _loc1_.data = model.attackContributionList[_loc3_ - 1];
            _itemBox.addChild(_loc1_);
            _loc3_++;
         }
         _scrollPanel.beginChanges();
         _scrollPanel.invalidateViewport();
         _scrollPanel.commitChanges();
         if(_loc2_ <= 0)
         {
            _noRecordText.text = LanguageMgr.GetTranslation("CrossGuildAttackContributionFrame.noRecordText.text");
         }
         else
         {
            _noRecordText.text = "";
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
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("CrossGuildAttackContributionFrame.titleText.text");
      }
      
      private function get model() : CrossGuildModel
      {
         return CrossGuildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_noRecordText);
         _noRecordText = null;
         ObjectUtils.disposeObject(_titleBack);
         _titleBack = null;
         ObjectUtils.disposeObject(_numTitleText);
         _numTitleText = null;
         ObjectUtils.disposeObject(_contribuutionTitleText);
         _contribuutionTitleText = null;
         ObjectUtils.disposeObject(_infoTitleText);
         _infoTitleText = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_itemBox);
         _itemBox = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         super.dispose();
      }
   }
}

