package question
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.QuestionManager;
   import mvc.module.question.QuestionModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.CommonDropTempInfo;
   import yishi.datas.templates.QuestionTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class QuestionFrame extends Frame implements IManualSize
   {
      
      private var _bg:Bitmap;
      
      private var _txtBg:Bitmap;
      
      private var _remainTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _itemList:Array;
      
      private var _submitBtn:IconButton;
      
      public function QuestionFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,790,595);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("questionFrame.titleText.text");
         _bg = ComponentFactory.Instance.creatBitmap("asset.questionFrame.bg");
         _txtBg = ComponentFactory.Instance.creatBitmap("asset.questionFrame.txtBg");
         _remainTxt = ComponentFactory.Instance.creatComponentByStylename("questionFrame.remainTxt");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("questionFrame.timeTxt");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("questionFrame.descTxt");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("questionFrame.ScrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("questionFrame.vBox");
         _submitBtn = ComponentFactory.Instance.creatComponentByStylename("questionFrame.submitBtn");
         addToContent(_bg);
         addToContent(_txtBg);
         addToContent(_remainTxt);
         addToContent(_timeTxt);
         addToContent(_descTxt);
         addToContent(_vBox);
         addToContent(_scrollPanel);
         addToContent(_submitBtn);
         _scrollPanel.setView(_vBox);
         _remainTxt.text = LanguageMgr.GetTranslation("questionFrame.remainTxt.text");
         _descTxt.text = LanguageMgr.GetTranslation("questionFrame.descTxt.text");
         initRewards();
         initSubject();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("QUESTION_UPDATE",this,__questionUpdateHandler);
         _submitBtn.addEventListener("click",__submitBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("QUESTION_UPDATE",this,__questionUpdateHandler);
         _submitBtn.removeEventListener("click",__submitBtnClickHandler);
      }
      
      private function __submitBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:QuestionItem = null;
         var _loc6_:QuestionTempInfo = null;
         var _loc2_:String = "";
         var _loc3_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _itemList.length)
         {
            _loc4_ = _itemList[_loc5_];
            _loc6_ = _loc4_.data;
            if(_loc6_.str == "")
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("questionFrame.submitBtn.text",_loc5_ + 1));
               return;
            }
            _loc3_.push(_loc6_.str);
            _loc5_++;
         }
         _loc2_ = _loc3_.join("|");
         QuestionManager.instance.send(_loc2_);
      }
      
      private function __questionUpdateHandler(param1:String, param2:Object) : void
      {
         if(model.isOpen)
         {
            refreshView();
         }
         else
         {
            dispose();
         }
      }
      
      private function initRewards() : void
      {
         var _loc2_:GoodsInfo = null;
         var _loc1_:BaseItemView = null;
         var _loc5_:Dictionary = TempleteManager.instance.questionDropTempCate.getTemplates();
         var _loc3_:int = 0;
         for each(var _loc4_:CommonDropTempInfo in _loc5_)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("core.normal.BaseItemView");
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = _loc4_.itemId;
            _loc2_.count = _loc4_.count;
            _loc1_.data = _loc2_;
            _loc1_.x = 35 + int(_loc3_ % 4) * 70;
            _loc1_.y = 278 + int(_loc3_ / 4) * 70;
            addToContent(_loc1_);
            _loc3_++;
         }
      }
      
      private function initSubject() : void
      {
         var _loc2_:QuestionItem = null;
         var _loc4_:QuestionTempInfo = null;
         var _loc3_:int = 0;
         ObjectUtils.disposeAllChildren(_vBox);
         _itemList = [];
         var _loc1_:Array = TempleteManager.instance.questionTempCate.getTempArr();
         _vBox.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = _loc1_[_loc3_] as QuestionTempInfo;
            _loc2_ = new QuestionItem();
            _loc2_.data = _loc4_;
            _vBox.addChild(_loc2_);
            _itemList.push(_loc2_);
            _loc3_++;
         }
         _vBox.commitChanges();
         _scrollPanel.invalidateViewport();
      }
      
      public function refreshView() : void
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc2_:String = null;
         var _loc3_:QuestionItem = null;
         var _loc7_:QuestionTempInfo = null;
         var _loc1_:Date = DateFormatter.parse(model.stopTime,"YYYY-MM-DD hh:mm:ss");
         var _loc6_:String = DateFormatter.timeFormat1(_loc1_);
         _timeTxt.text = _loc6_;
         if(model.selectedString != "")
         {
            _submitBtn.enable = false;
            _loc4_ = model.selectedString.split("|");
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc2_ = _loc4_[_loc5_];
               if(_itemList[_loc5_])
               {
                  _loc3_ = _itemList[_loc5_];
                  _loc7_ = _loc3_.data;
                  _loc7_.str = _loc2_;
                  _loc3_.data = _loc7_;
                  _loc3_.setEnable = false;
               }
               _loc5_++;
            }
         }
      }
      
      private function get model() : QuestionModel
      {
         return QuestionManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
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
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_txtBg);
         _txtBg = null;
         ObjectUtils.disposeObject(_remainTxt);
         _remainTxt = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         ObjectUtils.disposeObject(_submitBtn);
         _submitBtn = null;
         ObjectUtils.disposeAllChildren(_vBox);
         ObjectUtils.disposeAllChildren(_scrollPanel);
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

