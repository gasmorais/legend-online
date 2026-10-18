package star
{
   import cell.view.starbag.StarBagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.StarEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.star.StarInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.StarManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StarHelper;
   import yishi.view.base.Progress;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class SubStarFrame extends Frame implements IManualSize
   {
      
      private var _back:MutipleImage;
      
      private var _cell:StarBagCell;
      
      private var _hasSubSpr:Sprite;
      
      private var _noSubSpr:Sprite;
      
      private var _txtBack:Bitmap;
      
      private var _proBack:Bitmap;
      
      private var _noActBack:Bitmap;
      
      private var _decribeImp:Bitmap;
      
      private var _subBtn:IconButton;
      
      private var _actBtn:IconButton;
      
      private var _lvImage:Image;
      
      private var _inputImage:Image;
      
      private var _progress:Progress;
      
      private var _lvTxt:FilterFrameText;
      
      private var _curTxt:FilterFrameText;
      
      private var _nextTxt:FilterFrameText;
      
      private var _curCount:FilterFrameText;
      
      private var _needCount:FilterFrameText;
      
      private var _inputTxt:FilterFrameText;
      
      private var _itemIcon:BaseItemView;
      
      private var _curCount2:FilterFrameText;
      
      private var _itemId:int = 208061;
      
      private var _starList:SimpleTileList;
      
      private var _list:Vector.<StarBagCell>;
      
      private var _starDic:Dictionary;
      
      private var _panel:ScrollPanel;
      
      public function SubStarFrame()
      {
         super();
         initView();
         initStarList();
         refreshView();
         initEvent();
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,445,600);
      }
      
      private function initStarList() : void
      {
         var _loc3_:StarInfo = null;
         var _loc2_:int = 0;
         addNullItems(18);
         var _loc1_:Array = StarManager.instance.canShowSubList;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_] as StarInfo;
            if(_loc2_ >= _list.length)
            {
               addNullItems(6);
            }
            if(_loc2_ < _list.length)
            {
               _list[_loc2_].data = _loc3_;
               _list[_loc2_].bagType = _loc3_.bagType;
               _list[_loc2_].bagPos = _loc3_.pos;
               _starDic[_loc3_.bagType + "_" + _loc3_.pos] = _list[_loc2_];
            }
            _loc2_++;
         }
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("star.SubStarFram.titleTxt");
         _back = ComponentFactory.Instance.creatComponentByStylename("SubStarFrame.back");
         _cell = ComponentFactory.Instance.creatCustomObject("star.SmallStarBagCell");
         _subBtn = ComponentFactory.Instance.creatComponentByStylename("SubStarFrame.subBtn");
         _actBtn = ComponentFactory.Instance.creatComponentByStylename("SubStarFrame.actBtn");
         _txtBack = ComponentFactory.Instance.creatBitmap("asset.star.SubStarFrame.txtBack");
         _proBack = ComponentFactory.Instance.creatBitmap("asset.star.SubStarFrame.proBack");
         _noActBack = ComponentFactory.Instance.creatBitmap("asset.star.SubStarFrame.noActBack");
         _decribeImp = ComponentFactory.Instance.creatBitmap("asset.star.SubStarFram.decribeImp");
         _lvImage = ComponentFactory.Instance.creatComponentByStylename("SubStarFrame.lvImage");
         _inputImage = ComponentFactory.Instance.creatComponentByStylename("SubStarFrame.inputImage");
         _itemIcon = ComponentFactory.Instance.creatCustomObject("SubStarFrame.itemIcon");
         _progress = ComponentFactory.Instance.creatComponentByStylename("SubStarFrame.progress");
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("SubStarFrame.lvTxt");
         _curTxt = ComponentFactory.Instance.creatComponentByStylename("SubStarFrame.curTxt");
         _nextTxt = ComponentFactory.Instance.creatComponentByStylename("SubStarFrame.nextTxt");
         _curCount = ComponentFactory.Instance.creatComponentByStylename("SubStarFrame.curCount");
         _needCount = ComponentFactory.Instance.creatComponentByStylename("SubStarFrame.needCount");
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("SubStarFrame.inputTxt");
         _starList = ComponentFactory.Instance.creatCustomObject("SubStarFrame.SimpleTileList",[6]);
         _panel = ComponentFactory.Instance.creatComponentByStylename("SubStarFrame.panel");
         _curCount2 = ComponentFactory.Instance.creatComponentByStylename("SubStarFrame.curCount");
         _hasSubSpr = new Sprite();
         _noSubSpr = new Sprite();
         _starDic = new Dictionary();
         _list = new Vector.<StarBagCell>();
         addToContent(_back);
         addToContent(_cell);
         addToContent(_txtBack);
         addToContent(_decribeImp);
         addToContent(_curCount2);
         _curCount2.x = 148;
         _curCount2.y = 226;
         addToContent(_hasSubSpr);
         addToContent(_noSubSpr);
         addToContent(_curTxt);
         addToContent(_nextTxt);
         addToContent(_panel);
         _hasSubSpr.addChild(_lvImage);
         _hasSubSpr.addChild(_lvTxt);
         _hasSubSpr.addChild(_proBack);
         _hasSubSpr.addChild(_progress);
         _hasSubSpr.addChild(_itemIcon);
         _hasSubSpr.addChild(_curCount);
         _hasSubSpr.addChild(_needCount);
         _hasSubSpr.addChild(_inputImage);
         _hasSubSpr.addChild(_inputTxt);
         _hasSubSpr.addChild(_subBtn);
         _noSubSpr.addChild(_noActBack);
         _noActBack.x = -45;
         _noSubSpr.addChild(_actBtn);
         _hasSubSpr.x = 61;
         _hasSubSpr.y = 115;
         _noSubSpr.x = 115;
         _noSubSpr.y = 115;
         _cell.acceptDrop = true;
         _cell.data = StarManager.instance.getStarInfoByBagTypeAndPos(3,0);
         _cell.bagType = 3;
         _cell.areaType = 1;
         _cell.bagPos = 0;
         _cell.lock = false;
         _cell.x = 174;
         _cell.y = 23;
         _needCount.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelCostTxt");
         var _loc1_:GoodsInfo = new GoodsInfo();
         _loc1_.templateId = _itemId;
         _itemIcon.data = _loc1_;
         _inputTxt.restrict = "0-9";
         _panel.setView(_starList);
      }
      
      private function unitView() : void
      {
         if(_back)
         {
            _back.dispose();
         }
         _back = null;
         if(_cell)
         {
            _cell.dispose();
         }
         _cell = null;
         if(_panel)
         {
            _panel.dispose();
         }
         _panel = null;
         if(_subBtn)
         {
            _subBtn.dispose();
         }
         _subBtn = null;
         if(_actBtn)
         {
            _actBtn.dispose();
         }
         _actBtn = null;
         if(_lvImage)
         {
            _lvImage.dispose();
         }
         _lvImage = null;
         if(_inputImage)
         {
            _inputImage.dispose();
         }
         _inputImage = null;
         if(_progress)
         {
            _progress.dispose();
         }
         _progress = null;
         if(_lvTxt)
         {
            _lvTxt.dispose();
         }
         _lvTxt = null;
         if(_curTxt)
         {
            _curTxt.dispose();
         }
         _curTxt = null;
         if(_nextTxt)
         {
            _nextTxt.dispose();
         }
         _nextTxt = null;
         if(_curCount)
         {
            _curCount.dispose();
         }
         _curCount = null;
         if(_needCount)
         {
            _needCount.dispose();
         }
         _needCount = null;
         if(_inputTxt)
         {
            _inputTxt.dispose();
         }
         _inputTxt = null;
         if(_itemIcon)
         {
            _itemIcon.dispose();
         }
         _itemIcon = null;
         ObjectUtils.disposeObject(_txtBack);
         _txtBack = null;
         ObjectUtils.disposeObject(_proBack);
         _proBack = null;
         ObjectUtils.disposeObject(_noActBack);
         _noActBack = null;
         ObjectUtils.disposeObject(_decribeImp);
         _decribeImp = null;
         ObjectUtils.disposeObject(_curCount2);
         _curCount2 = null;
         if(_starList)
         {
            _starList.dispose();
         }
         _starList = null;
         _hasSubSpr = null;
         _noSubSpr = null;
         _starDic = null;
         cleanList();
         _list = null;
      }
      
      private function cleanList() : void
      {
         if(_list)
         {
            while(_list.length > 0)
            {
               _list.pop().dispose();
            }
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         StarManager.instance.addEventListener("UPDATE_STAR",__starUpdateHandler);
         StarManager.instance.addEventListener("DELETE_STAR",__starDeleteHandler);
         if(_inputTxt)
         {
            _inputTxt.addEventListener("change",__textChangeHandler);
         }
         if(_subBtn)
         {
            _subBtn.addEventListener("click",__subBtnHandler);
         }
         if(_actBtn)
         {
            _actBtn.addEventListener("click",__actBtnHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         StarManager.instance.removeEventListener("UPDATE_STAR",__starUpdateHandler);
         StarManager.instance.removeEventListener("DELETE_STAR",__starDeleteHandler);
         if(_inputTxt)
         {
            _inputTxt.removeEventListener("change",__textChangeHandler);
         }
         if(_subBtn)
         {
            _subBtn.removeEventListener("click",__subBtnHandler);
         }
         if(_actBtn)
         {
            _actBtn.removeEventListener("click",__actBtnHandler);
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
      
      private function __subBtnHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(_cell && _cell.data && _cell.data.template.Profile == 8)
         {
            _loc3_ = parseInt(_inputTxt.text) ? parseInt(_inputTxt.text) : 0;
            _loc2_ = int(PlayerCurrencyManager.instance.currencyInfo.newMagicDust.amount);
            if(_loc3_ > _loc2_)
            {
               _loc3_ = _loc2_;
            }
            if(_loc2_ <= 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("star.SubStarFram.SubBtnTips1"));
            }
            else if(_loc3_ <= 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("star.SubStarFram.SubBtnTips2"));
            }
            else
            {
               StarManager.instance.sendStarSublime(1,_loc3_);
            }
         }
      }
      
      private function __actBtnHandler(param1:MouseEvent) : void
      {
         if(_cell && _cell.data && _cell.data.template.Profile == 7 && _cell.data.grade == 10)
         {
            _actBtn.enable = false;
            StarManager.instance.sendStarSublime(0);
         }
      }
      
      private function __textChangeHandler(param1:Event) : void
      {
         var _loc3_:int = parseInt(_inputTxt.text);
         var _loc2_:int = int(PlayerCurrencyManager.instance.currencyInfo.newMagicDust.amount);
         if(!_loc3_)
         {
            _loc3_ = 0;
         }
         if(_loc3_ > _loc2_)
         {
            _inputTxt.text = _loc2_.toString();
         }
         else
         {
            _inputTxt.text = _loc3_.toString();
         }
         _subBtn.enable = _loc2_ > 0;
      }
      
      private function __starUpdateHandler(param1:StarEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:StarInfo = param1.starInfo;
         if(_loc3_.bagType == 3)
         {
            _cell.data = _loc3_;
            refreshView();
         }
         else if(_loc3_.bagType == 1 || _loc3_.bagType == 2)
         {
            if(!checkCanShow(_loc3_))
            {
               return;
            }
            if(!_starDic[_loc3_.bagType + "_" + _loc3_.pos])
            {
               _loc2_ = 0;
               while(_loc2_ < _list.length)
               {
                  if(_list[_loc2_].bagPos == -1)
                  {
                     _starDic[_loc3_.bagType + "_" + _loc3_.pos] = _list[_loc2_];
                     break;
                  }
                  _loc2_++;
               }
               if(!_starDic[_loc3_.bagType + "_" + _loc3_.pos])
               {
                  addNullItems(6);
                  _starDic[_loc3_.bagType + "_" + _loc3_.pos] = _list[_list.length - 6];
               }
            }
            if(_starDic[_loc3_.bagType + "_" + _loc3_.pos])
            {
               _starDic[_loc3_.bagType + "_" + _loc3_.pos].data = _loc3_;
            }
         }
      }
      
      private function checkCanShow(param1:StarInfo) : Boolean
      {
         if(param1.template.Profile >= 8 || param1.template.Profile == 7 && param1.grade == 10 && param1.tempId != 107)
         {
            return true;
         }
         return false;
      }
      
      private function __starDeleteHandler(param1:StarEvent) : void
      {
         var _loc2_:StarInfo = param1.starInfo;
         if(_loc2_.bagType == 3)
         {
            _cell.data = null;
            refreshView();
         }
         else if(_loc2_.bagType == 1 || _loc2_.bagType == 2)
         {
            if(_starDic[_loc2_.bagType + "_" + _loc2_.pos])
            {
               _starDic[_loc2_.bagType + "_" + _loc2_.pos].data = null;
            }
         }
      }
      
      private function refreshView() : void
      {
         var _loc1_:StarInfo = null;
         var _loc2_:UpgradeTemplateInfo = null;
         var _loc3_:int = int(PlayerCurrencyManager.instance.currencyInfo.newMagicDust.amount);
         if(_cell && _cell.data)
         {
            if(_cell.data.template.Profile == 8)
            {
               _hasSubSpr.visible = true;
               _noSubSpr.visible = false;
               _txtBack.y = 110;
               _curTxt.y = 150;
               _nextTxt.y = 170;
               _lvTxt.text = _cell.data.grade + "";
               if(_cell.data.grade < 10)
               {
                  _loc2_ = TempleteManager.instance.getTemplateByLevelAndType(_cell.data.grade + 1,60);
                  _progress.setData(_cell.data.gp,_loc2_.Data);
                  _loc1_ = new StarInfo();
                  _loc1_.tempId = _cell.data.tempId;
                  _loc1_.grade = _cell.data.grade + 1;
               }
               else
               {
                  _loc2_ = TempleteManager.instance.getTemplateByLevelAndType(_cell.data.grade,60);
                  _progress.setData(_loc2_.Data,_loc2_.Data);
               }
            }
            else if(_cell.data.template.Profile == 7)
            {
               _hasSubSpr.visible = false;
               _noSubSpr.visible = true;
               _actBtn.enable = true;
               _txtBack.y = 125;
               _curTxt.y = 162;
               _nextTxt.y = 182;
               _loc1_ = StarManager.instance.getHighStar(_cell.data);
            }
            _curTxt.text = LanguageMgr.GetTranslation("star.SubStarFram.buffTxt1",StarHelper.getStarAttributeAdd(_cell.data));
            if(_loc1_)
            {
               _nextTxt.text = LanguageMgr.GetTranslation("star.SubStarFram.buffTxt2",StarHelper.getStarAttributeAdd(_loc1_));
            }
            else
            {
               _nextTxt.text = LanguageMgr.GetTranslation("star.SubStarFram.buffTxt2","- -");
            }
            _curCount.text = LanguageMgr.GetTranslation("star.SubStarFram.countTxt1",_loc3_);
            if(!parseInt(_inputTxt.text))
            {
               _inputTxt.text = _loc3_ + "";
            }
            _cell.alpha = 1;
            _subBtn.enable = _loc3_ > 0;
            _decribeImp.visible = false;
            _curCount2.text = "";
         }
         else
         {
            _decribeImp.visible = true;
            _hasSubSpr.visible = false;
            _noSubSpr.visible = false;
            _curCount2.text = LanguageMgr.GetTranslation("star.SubStarFram.countTxt1",_loc3_);
            _curTxt.text = "";
            _nextTxt.text = "";
            _txtBack.y = 125;
            _cell.alpha = 0;
         }
      }
      
      private function addNullItems(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:StarBagCell = null;
         if(param1 <= 0)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("star.SmallStarBagCell");
            _loc2_.acceptDrop = true;
            _loc2_.setScaleCell();
            _loc2_.data = null;
            _loc2_.bagPos = -1;
            _loc2_.areaType = 1;
            _loc2_.lock = false;
            _starList.addChild(_loc2_);
            _list.push(_loc2_);
            _loc3_++;
         }
         _panel.invalidateViewport();
         _starList.commitChanges();
         _starList.beginChanges();
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         StarManager.instance.hideToBag();
         removeEvent();
         unitView();
         super.dispose();
      }
   }
}

