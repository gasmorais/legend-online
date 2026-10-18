package theseus.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusWarsoulItemInfo;
   import mvc.module.theseus.TheseusYiCellInfo;
   import mvc.module.theseus.TheseussoulModel;
   import mvc.module.theseus.WarFrameItemInfo;
   import theseus.item.TheseussouYiCell;
   import theseus.item.TheseussoulYiItem;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.TheseusRageTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseIconView;
   
   public class TheseussoulyiPageView extends Sprite
   {
      
      public var _YiBg:Bitmap;
      
      public var _strengthBtn:IconButton;
      
      public var _infoBtn:BaseButton;
      
      public var _chooseTxt:GradientText;
      
      public var _before:TheseussoulYiItem;
      
      public var _after:TheseussoulYiItem;
      
      public var _yiIcon:BaseIconView;
      
      private var _bagBack:Scale9CornerImage;
      
      private var _cellList:Vector.<TheseussouYiCell>;
      
      private var _currSelectIdx:int = 1;
      
      private var _gInfo:GoodsInfo;
      
      private var _metrialTxt:FilterFrameText;
      
      private var _maxTip:FilterFrameText;
      
      private var _centerIcons:ScaleFrameImage;
      
      private const POSLIST:Array = [1,3,4,5,2,6,9,10,11,12,7,8];
      
      public function TheseussoulyiPageView()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      public function set currSelectIdx(param1:int) : void
      {
         _currSelectIdx = param1;
         for each(var _loc2_:TheseussouYiCell in _cellList)
         {
            if(_loc2_.pos == _currSelectIdx)
            {
               _loc2_.select = true;
               _centerIcons.setFrame(_loc2_.sontype + 1);
               updateStrengh(_loc2_.level,_loc2_.pos,_loc2_.sontype,_loc2_.addList);
            }
            else
            {
               _loc2_.select = false;
            }
         }
      }
      
      private function updateStrengh(param1:int, param2:int, param3:int, param4:Array = null) : void
      {
         var _loc7_:Array = null;
         var _loc9_:GoodsTemplateInfo = null;
         var _loc11_:SimpleDictionary = null;
         var _loc8_:WarFrameItemInfo = null;
         var _loc6_:int = 0;
         var _loc10_:int = 0;
         var _loc12_:TheseusRageTempInfo = TempleteManager.instance.theseusRageTempCate.getOneTempInfo(param2,param1);
         var _loc5_:TheseusRageTempInfo = TempleteManager.instance.theseusRageTempCate.getOneTempInfo(param2,param1 + 1);
         if(_loc12_)
         {
            _loc7_ = param4.concat();
            _loc7_.unshift(_loc12_);
            _before.dataList = _loc7_;
            _chooseTxt.text = LanguageMgr.GetTranslation("theseus.equip.part" + param3) + "  Lv." + param1;
         }
         if(_loc5_)
         {
            _loc9_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc5_.NeedItem);
            _yiIcon.icon = IconFactory.getGoodsIconByTID(_loc9_.TemplateId);
            _gInfo.templateId = _loc9_.TemplateId;
            _yiIcon.tipData = _gInfo;
            _loc11_ = TheseussoulManager.Instance.model.armorBagDic;
            for each(var _loc13_:WarFrameItemInfo in _loc11_)
            {
               if(_loc9_.TemplateId == _loc13_.warTempInfo.TemplateId)
               {
                  _loc8_ = _loc13_;
               }
            }
            _loc6_ = int(_loc5_.NeedItemNum);
            _metrialTxt.setFrame(1);
            if(_loc8_)
            {
               _loc10_ = int(_loc8_.count);
               _metrialTxt.htmlText = LanguageMgr.GetTranslation("theseus.yi.metrialNeed",_loc10_ + "/" + _loc6_);
               if(_loc10_ >= _loc6_)
               {
                  _metrialTxt.setFrame(2);
               }
            }
            else
            {
               _metrialTxt.htmlText = "0/" + _loc6_;
            }
            _loc7_ = param4.concat();
            _loc7_.unshift(_loc5_);
            _after.dataList = _loc7_;
            _after.visible = true;
            _strengthBtn.enable = true;
            _maxTip.visible = false;
         }
         else
         {
            _after.visible = false;
            _strengthBtn.enable = false;
            _maxTip.visible = true;
            _yiIcon.icon = null;
            _metrialTxt.htmlText = "";
         }
      }
      
      private function initView() : void
      {
         _gInfo = new GoodsInfo();
         _YiBg = ComponentFactory.Instance.creatBitmap("asset.theseus.YiBg");
         _bagBack = ComponentFactory.Instance.creatComponentByStylename("TheseussoulyiPageView.BagBack");
         _strengthBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.strengthBtn");
         _infoBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.infoBtn");
         _chooseTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.GT.chooseTxt");
         _before = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.before",[1]);
         _after = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.after",[2]);
         _yiIcon = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.yiIcon");
         _metrialTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.yiMetrial");
         _maxTip = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.yiMaxTxt");
         _centerIcons = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.yiCenterIcons");
         addChild(_bagBack);
         addChild(_YiBg);
         addChild(_strengthBtn);
         addChild(_infoBtn);
         initCells();
         addChild(_chooseTxt);
         addChild(_before);
         addChild(_after);
         addChild(_yiIcon);
         addChild(_metrialTxt);
         addChild(_maxTip);
         addChild(_centerIcons);
         _after.visible = false;
         _maxTip.text = LanguageMgr.GetTranslation("theseus.yi.max");
         _maxTip.visible = false;
      }
      
      private function initCells() : void
      {
         var _loc1_:TheseussouYiCell = null;
         var _loc2_:int = 0;
         _cellList = new Vector.<TheseussouYiCell>();
         var _loc3_:Array = TheseussoulModel.SONTYPES;
         _loc2_ = 0;
         while(_loc2_ < 12)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.yiCell" + (_loc2_ + 1));
            _loc1_.pos = POSLIST[_loc2_];
            _loc1_.sontype = _loc3_[_loc2_];
            _loc1_.level = 0;
            _cellList.push(_loc1_);
            addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function refreshView() : void
      {
         var _loc2_:TheseussouYiCell = null;
         var _loc3_:int = 0;
         var _loc8_:Array = null;
         var _loc4_:int = 0;
         var _loc10_:int = 0;
         var _loc7_:Array = TheseussoulManager.Instance.model.yiDic.getList();
         for each(var _loc9_:TheseusYiCellInfo in _loc7_)
         {
            _loc3_ = POSLIST.indexOf(_loc9_.pos);
            _loc2_ = _cellList[_loc3_];
            _loc2_.level = _loc9_.level;
            _loc2_.initAddLevel();
         }
         var _loc1_:Array = TheseussoulManager.Instance.warsoulModel.getEquipBodyList();
         for each(var _loc6_:TheseusWarsoulItemInfo in _loc1_)
         {
            if(_loc6_.reformBuffList.length > 0)
            {
               for each(var _loc5_:String in _loc6_.reformBuffList)
               {
                  _loc8_ = _loc5_.split(",");
                  _loc4_ = int(_loc8_[0]);
                  _loc10_ = int(_loc8_[1]);
                  _loc3_ = POSLIST.indexOf(_loc4_);
                  _loc2_ = _cellList[_loc3_];
                  _loc2_.addLevel(_loc10_);
               }
            }
         }
         currSelectIdx = _currSelectIdx;
      }
      
      private function initEvent() : void
      {
         _strengthBtn.addEventListener("click",clickStrengHandler);
         _infoBtn.addEventListener("click",infoHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_YI_UPDATE",yiUpdateHandler);
         for each(var _loc1_:TheseussouYiCell in _cellList)
         {
            _loc1_.addEventListener("click",itemClickHandler);
            _loc1_.buttonMode = true;
         }
      }
      
      private function removeEvent() : void
      {
         _strengthBtn.removeEventListener("click",clickStrengHandler);
         _infoBtn.removeEventListener("click",infoHandler);
         TheseussoulManager.Instance.removeEventListener("EVENT_YI_UPDATE",yiUpdateHandler);
         for each(var _loc1_:TheseussouYiCell in _cellList)
         {
            _loc1_.removeEventListener("click",itemClickHandler);
         }
      }
      
      private function itemClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:TheseussouYiCell = param1.currentTarget as TheseussouYiCell;
         currSelectIdx = _loc2_.pos;
      }
      
      private function yiUpdateHandler(param1:Event) : void
      {
         refreshView();
      }
      
      private function clickStrengHandler(param1:MouseEvent) : void
      {
         TheseussoulManager.Instance.doSomething(4,0,0,_currSelectIdx);
      }
      
      private function infoHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("theseussoul",2);
      }
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:TheseussouYiCell in _cellList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _cellList = null;
         ObjectUtils.disposeObject(_YiBg);
         _YiBg = null;
         ObjectUtils.disposeObject(_bagBack);
         _bagBack = null;
         ObjectUtils.disposeObject(_strengthBtn);
         _strengthBtn = null;
         ObjectUtils.disposeObject(_infoBtn);
         _infoBtn = null;
         ObjectUtils.disposeObject(_chooseTxt);
         _chooseTxt = null;
         ObjectUtils.disposeObject(_before);
         _before = null;
         ObjectUtils.disposeObject(_after);
         _after = null;
         ObjectUtils.disposeObject(_yiIcon);
         _yiIcon = null;
         ObjectUtils.disposeObject(_metrialTxt);
         _metrialTxt = null;
         ObjectUtils.disposeObject(_centerIcons);
         _centerIcons = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _gInfo = null;
      }
   }
}

