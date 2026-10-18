package apex.award
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.ApexManager;
   
   public class ApexAwardListFrame extends Frame implements IManualSize
   {
      
      private var _txtAwardListItemStr1:FilterFrameText;
      
      private var _txtAwardListItemStr2:FilterFrameText;
      
      private var _txtAwardListItemStr3:FilterFrameText;
      
      private var _bit0:Bitmap;
      
      private var bg:MutipleImage;
      
      private var guessDataList:Array;
      
      private var vbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      public function ApexAwardListFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,376,389);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("apex.awardList.title");
         _txtAwardListItemStr1 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtAwardListItemStr1");
         _txtAwardListItemStr2 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtAwardListItemStr2");
         _txtAwardListItemStr3 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtAwardListItemStr3");
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.apex.awardList.bg");
         bg = ComponentFactory.Instance.creatComponentByStylename("apex.award.ApexAwardListFrame.framebg");
         addChild(bg);
         addChild(_bit0);
         addChild(_txtAwardListItemStr1);
         addChild(_txtAwardListItemStr2);
         addChild(_txtAwardListItemStr3);
         _txtAwardListItemStr1.text = LanguageMgr.GetTranslation("apex.awardlist.str1");
         _txtAwardListItemStr2.text = LanguageMgr.GetTranslation("apex.awardlist.str2");
         _txtAwardListItemStr3.text = LanguageMgr.GetTranslation("apex.awardlist.str3");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("apex.scrollPanel.award");
         addChild(_scrollPanel);
         guessDataList = ApexManager.instance.model.betWinPlayers;
         initGuessArr();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
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
      
      private function initGuessArr() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ApexAwardListItem = null;
         vbox = ComponentFactory.Instance.creatComponentByStylename("apex.vbox.award.vbox");
         addChild(vbox);
         _loc2_ = 0;
         while(_loc2_ < guessDataList.length)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("apex.award.ApexAwardListItem");
            _loc1_.data = guessDataList[_loc2_];
            vbox.addChild(_loc1_);
            _loc2_++;
         }
         _scrollPanel.beginChanges();
         _scrollPanel.setView(vbox);
         _scrollPanel.invalidateViewport();
         vbox.commitChanges();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_txtAwardListItemStr1);
         _txtAwardListItemStr1 = null;
         ObjectUtils.disposeObject(_txtAwardListItemStr2);
         _txtAwardListItemStr2 = null;
         ObjectUtils.disposeObject(_txtAwardListItemStr3);
         _txtAwardListItemStr3 = null;
         ObjectUtils.disposeObject(bg);
         bg = null;
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(vbox);
         vbox = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

