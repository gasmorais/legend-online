package theseus.war
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.theseus.AttributeUtils;
   import mvc.module.theseus.TheseusWarsoulItemInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.GoodsHelp;
   import yishi.view.community.BaseItemView;
   
   public class TheseuswarGZMFrame extends Frame implements IManualSize
   {
      
      private var _itemIcon:BaseItemView;
      
      private var _itemName:FilterFrameText;
      
      private var _numBg:Image;
      
      private var _numTitleTxt:FilterFrameText;
      
      private var _numTxt:FilterFrameText;
      
      private var _succTxt:FilterFrameText;
      
      private var _addBtn:BaseButton;
      
      private var _duceBtn:BaseButton;
      
      private var _confrimBtn:IconButton;
      
      private var _currNum:int;
      
      private var _returnNoChange:int;
      
      private var _returnFial:int;
      
      private var _hasNum:int;
      
      private var _failNum:int;
      
      private var _noChangeNum:int;
      
      private var _succNum:int;
      
      private var _onePoint:int;
      
      private var _needMax:int;
      
      private var _realMax:int;
      
      public function TheseuswarGZMFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,335,350);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("theseus.war.gzAddT");
         _itemIcon = ComponentFactory.Instance.creatCustomObject("theseus.war.addMetralItemView");
         _itemName = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warGzMMnameTxt");
         _numBg = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warAddInputBg");
         _numTitleTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warAddTitle");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warAddNumTxt");
         _succTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warsuccTitle");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("theseus.war.AddButton");
         _duceBtn = ComponentFactory.Instance.creatComponentByStylename("theseus.war.DeleteButton");
         _confrimBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.waraddConfrimBtn");
         addToContent(_itemIcon);
         addToContent(_itemName);
         addToContent(_numBg);
         addToContent(_numTitleTxt);
         addToContent(_numTxt);
         addToContent(_succTxt);
         addToContent(_addBtn);
         addToContent(_duceBtn);
         addToContent(_confrimBtn);
         _numTitleTxt.text = LanguageMgr.GetTranslation("theseus.war.gzAddT") + ":";
         _numTxt.text = "0";
         _confrimBtn.enable = false;
         _duceBtn.enable = false;
      }
      
      public function show(param1:Array) : void
      {
         var _loc6_:TheseusWarsoulItemInfo = param1[0];
         var _loc2_:int = int(param1[1]);
         var _loc4_:GoodsInfo = new GoodsInfo();
         _loc4_.templateId = _loc6_.warReformTempInfo.NeedStone;
         _itemIcon.data = _loc4_;
         _onePoint = _loc4_.templateInfo.Property2;
         var _loc5_:String = GoodsHelp.getGoodColorString(_loc4_.templateInfo.Profile);
         var _loc3_:String = AttributeUtils.getColorStr(_loc4_.templateInfo.TemplateName,_loc5_,false);
         _itemName.htmlText = _loc3_;
         _succNum = _loc6_.warReformTempInfo.SuccessProbability;
         _failNum = _loc6_.warReformTempInfo.FailProbability;
         _noChangeNum = _loc6_.warReformTempInfo.UnchangedProbability;
         _returnNoChange = _noChangeNum;
         _returnFial = _failNum;
         _hasNum = GoodsManager.instance.getGoodsNumByTempId(_loc4_.templateId);
         if(_failNum == 0 || _hasNum == 0)
         {
            _addBtn.enable = false;
            _duceBtn.enable = false;
            _numTxt.mouseEnabled = false;
            _confrimBtn.enable = false;
            _succTxt.text = LanguageMgr.GetTranslation("theseus.war.gz.gailv2",_succNum,_noChangeNum,_failNum);
         }
         else
         {
            _numTxt.mouseEnabled = true;
            _confrimBtn.enable = true;
            addEvent();
         }
         _needMax = Math.ceil(_failNum / _onePoint);
         _realMax = Math.min(_needMax,_hasNum);
         if(_loc2_ > _realMax)
         {
            _loc2_ = _realMax;
         }
         _numTxt.text = "" + _loc2_;
         numTxtChangehandler();
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function addEvent() : void
      {
         _addBtn.addEventListener("click",addHandler);
         _duceBtn.addEventListener("click",reduceHandler);
         _confrimBtn.addEventListener("click",confirmHandler);
         _numTxt.addEventListener("change",numTxtChangehandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _addBtn.removeEventListener("click",addHandler);
         _duceBtn.removeEventListener("click",reduceHandler);
         _confrimBtn.removeEventListener("click",confirmHandler);
         _numTxt.removeEventListener("change",numTxtChangehandler);
      }
      
      private function numTxtChangehandler(param1:Event = null) : void
      {
         var _loc2_:int = int(_numTxt.text);
         if(_loc2_ <= 0)
         {
            _loc2_ = 0;
         }
         if(_loc2_ >= _realMax)
         {
            _loc2_ = _realMax;
            _addBtn.enable = false;
         }
         else
         {
            _addBtn.enable = true;
         }
         if(int(_numTxt.text) != _loc2_)
         {
            _numTxt.text = "" + _loc2_;
         }
         if(_loc2_ > 0)
         {
            _duceBtn.enable = true;
         }
         else
         {
            _duceBtn.enable = false;
         }
         _currNum = _loc2_;
         _returnNoChange = _noChangeNum + _currNum * _onePoint;
         if(_returnNoChange > 100)
         {
            _returnNoChange = 100;
         }
         _returnFial = _failNum - _currNum * _onePoint;
         if(_returnFial < 0)
         {
            _returnFial = 0;
         }
         _succTxt.text = LanguageMgr.GetTranslation("theseus.war.gz.gailv2",_succNum,_returnNoChange,_returnFial);
      }
      
      private function addHandler(param1:MouseEvent) : void
      {
         _currNum = _currNum + 1;
         _numTxt.text = "" + _currNum;
         numTxtChangehandler();
      }
      
      private function reduceHandler(param1:MouseEvent) : void
      {
         _currNum = _currNum - 1;
         if(_currNum < 0)
         {
            _currNum = 0;
         }
         _numTxt.text = "" + _currNum;
         numTxtChangehandler();
      }
      
      private function confirmHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("Event.GzCountPrecent",[_succNum,_returnNoChange,_returnFial,_currNum]);
         dispose();
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
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_itemIcon);
         _itemIcon = null;
         ObjectUtils.disposeObject(_itemName);
         _itemName = null;
         ObjectUtils.disposeObject(_numBg);
         _numBg = null;
         ObjectUtils.disposeObject(_numTitleTxt);
         _numTitleTxt = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_succTxt);
         _succTxt = null;
         ObjectUtils.disposeObject(_addBtn);
         _addBtn = null;
         ObjectUtils.disposeObject(_duceBtn);
         _duceBtn = null;
         ObjectUtils.disposeObject(_confrimBtn);
         _confrimBtn = null;
         super.dispose();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

