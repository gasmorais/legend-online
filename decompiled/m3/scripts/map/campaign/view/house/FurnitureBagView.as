package map.campaign.view.house
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.HomeManager;
   import map.campaign.CampaignManager;
   import mvc.module.home.HomeModel;
   import yishi.datas.templates.FurnitureTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.WorldBossHelper;
   
   public class FurnitureBagView extends Component
   {
      
      private static const NUM:int = 30;
      
      private var _hBox1:HBox;
      
      private var _hBox2:HBox;
      
      private var _current:int;
      
      private var _total:int;
      
      private var _firstBtn:BaseButton;
      
      private var _lastBtn:BaseButton;
      
      private var _preBtn:IconButton;
      
      private var _nextBtn:IconButton;
      
      private var _pageTxt:FilterFrameText;
      
      private var _pageBack:Bitmap;
      
      private var _bottomSp:Sprite;
      
      private var _itemList:Vector.<FurnitureBagCell>;
      
      private var _typeView:FurnitureTypeView;
      
      private var _describeTxt:FilterFrameText;
      
      public function FurnitureBagView()
      {
         super();
         initView();
         initData();
         setBtnState();
         refreshCells();
         setDescribeTxt();
         initEvent();
      }
      
      private function initData() : void
      {
         _current = 1;
         _total = Math.ceil(furnitureList.length / 30);
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:FurnitureBagCell = null;
         _hBox1 = ComponentFactory.Instance.creatComponentByStylename("FurnitureBagView.HBox1");
         _hBox2 = ComponentFactory.Instance.creatComponentByStylename("FurnitureBagView.HBox2");
         _firstBtn = ComponentFactory.Instance.creatComponentByStylename("FurnitureBagView.firstBtn");
         _lastBtn = ComponentFactory.Instance.creatComponentByStylename("FurnitureBagView.lastBtn");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("FurnitureBagView.preBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("FurnitureBagView.nextBtn");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("FurnitureBagView.pageTxt");
         _pageBack = ComponentFactory.Instance.creatBitmap("asset.house.storePageTxtBack");
         _describeTxt = ComponentFactory.Instance.creatComponentByStylename("FurnitureBagView.describeTxt");
         _itemList = new Vector.<FurnitureBagCell>();
         _bottomSp = new Sprite();
         _typeView = new FurnitureTypeView();
         addChild(_typeView);
         addChild(_hBox1);
         addChild(_hBox2);
         addChild(_bottomSp);
         addChild(_describeTxt);
         _bottomSp.addChild(_firstBtn);
         _bottomSp.addChild(_lastBtn);
         _bottomSp.addChild(_preBtn);
         _bottomSp.addChild(_nextBtn);
         _bottomSp.addChild(_pageBack);
         _bottomSp.addChild(_pageTxt);
         _bottomSp.x = 357;
         _bottomSp.y = 105;
         _loc2_ = 0;
         while(_loc2_ < 30)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("FurnitureBagView.BagCell");
            _loc1_.furniture = null;
            if(_loc2_ < 30 / 2)
            {
               _hBox1.addChild(_loc1_);
            }
            else
            {
               _hBox2.addChild(_loc1_);
            }
            _itemList.push(_loc1_);
            _loc2_++;
         }
         _hBox1.refreshChildPos();
         _hBox2.refreshChildPos();
      }
      
      private function unitView() : void
      {
         if(_itemList)
         {
            while(_itemList.length > 0)
            {
               _itemList.pop().dispose();
            }
            _itemList = null;
         }
         if(_typeView)
         {
            _typeView.dispose();
         }
         _typeView = null;
         if(_describeTxt)
         {
            _describeTxt.dispose();
         }
         _describeTxt = null;
         if(_hBox1)
         {
            _hBox1.dispose();
         }
         _hBox1 = null;
         if(_hBox2)
         {
            _hBox2.dispose();
         }
         _hBox2 = null;
         if(_firstBtn)
         {
            _firstBtn.dispose();
         }
         _firstBtn = null;
         if(_lastBtn)
         {
            _lastBtn.dispose();
         }
         _lastBtn = null;
         if(_preBtn)
         {
            _preBtn.dispose();
         }
         _preBtn = null;
         if(_nextBtn)
         {
            _nextBtn.dispose();
         }
         _nextBtn = null;
         if(_pageTxt)
         {
            _pageTxt.dispose();
         }
         _pageTxt = null;
         ObjectUtils.disposeObject(_pageBack);
         _pageBack = null;
      }
      
      private function refreshCells() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<FurnitureTempInfo> = furnitureList;
         _loc2_ = 0;
         while(_loc2_ < 30)
         {
            if(_loc1_.length > (_current - 1) * 30 + _loc2_)
            {
               _itemList[_loc2_].furniture = _loc1_[(_current - 1) * 30 + _loc2_];
            }
            else
            {
               _itemList[_loc2_].furniture = null;
            }
            _loc2_++;
         }
      }
      
      private function refreshCountTxt() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _itemList.length)
         {
            _itemList[_loc1_].refreshTxt();
            _loc1_++;
         }
      }
      
      private function setDescribeTxt() : void
      {
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc6_:Array = null;
         var _loc5_:int = 0;
         var _loc2_:UpgradeTemplateInfo = null;
         var _loc3_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < model.fixUpList.length)
         {
            if(model.fixUpList[_loc5_].templateInfo.FurnitureType == _typeView.showType)
            {
               _loc3_++;
            }
            _loc5_++;
         }
         if(inHouse)
         {
            _loc4_ = int(model.selfInfo.houseLv);
            _loc2_ = TempleteManager.instance.getTemplateByLevelAndType(_loc4_,45);
            if(_loc2_)
            {
               _loc6_ = _loc2_.TemplateName.split(",");
               _loc1_ = parseInt(_loc6_[_typeView.showType - 1]);
               if(_typeView.showType == 1 || _typeView.showType == 2)
               {
                  _describeTxt.text = LanguageMgr.GetTranslation("FurnitureBagView.describeTxt1","--");
               }
               else
               {
                  _describeTxt.text = LanguageMgr.GetTranslation("FurnitureBagView.describeTxt1",_loc3_ + "/" + _loc1_);
               }
            }
            else
            {
               _describeTxt.text = "";
            }
         }
         else if(inHome)
         {
            _loc4_ = int(model.selfInfo.homeLv);
            _loc2_ = TempleteManager.instance.getTemplateByLevelAndType(_loc4_,46);
            if(_loc2_)
            {
               _loc6_ = _loc2_.TemplateName.split(",");
               _loc1_ = parseInt(_loc6_[_typeView.showType - 1]);
               _describeTxt.text = LanguageMgr.GetTranslation("FurnitureBagView.describeTxt2",_loc4_,_loc3_ + "/" + _loc1_);
            }
            else
            {
               _describeTxt.text = "";
            }
         }
      }
      
      private function initEvent() : void
      {
         if(_preBtn)
         {
            _preBtn.addEventListener("click",__pageBtnHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.addEventListener("click",__pageBtnHandler);
         }
         if(_firstBtn)
         {
            _firstBtn.addEventListener("click",__pageBtnHandler);
         }
         if(_lastBtn)
         {
            _lastBtn.addEventListener("click",__pageBtnHandler);
         }
         if(_typeView)
         {
            _typeView.addEventListener("change",__typeViewHandler);
         }
         MsgMan.addObserver("ChildEvent.HOME_INFO",this,__homeInfoHandler);
         MsgMan.addObserver("ChildEvent.ADD_OR_REMOVE",this,__addOrRemoveHandler);
         MsgMan.addObserver("ChildEvent.FIX_CHANGE",this,__fixUpChangeHandler);
      }
      
      private function removeEvent() : void
      {
         if(_preBtn)
         {
            _preBtn.removeEventListener("click",__pageBtnHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__pageBtnHandler);
         }
         if(_firstBtn)
         {
            _firstBtn.removeEventListener("click",__pageBtnHandler);
         }
         if(_lastBtn)
         {
            _lastBtn.removeEventListener("click",__pageBtnHandler);
         }
         if(_typeView)
         {
            _typeView.removeEventListener("change",__typeViewHandler);
         }
         MsgMan.removeObserver("ChildEvent.HOME_INFO",this,__homeInfoHandler);
         MsgMan.removeObserver("ChildEvent.ADD_OR_REMOVE",this,__addOrRemoveHandler);
         MsgMan.removeObserver("ChildEvent.FIX_CHANGE",this,__fixUpChangeHandler);
      }
      
      private function __typeViewHandler(param1:Event) : void
      {
         initData();
         setBtnState();
         refreshCells();
         setDescribeTxt();
         if(model.inBuy)
         {
            setBuyVisible(true);
         }
      }
      
      private function __fixUpChangeHandler(param1:String, param2:Object) : void
      {
         if(model.isSelf)
         {
            refreshCountTxt();
            setDescribeTxt();
         }
      }
      
      private function __homeInfoHandler(param1:String, param2:Object) : void
      {
         if(model.isSelf)
         {
            refreshCountTxt();
            setDescribeTxt();
         }
      }
      
      private function __addOrRemoveHandler(param1:String, param2:Object) : void
      {
         if(model.isSelf)
         {
            refreshCountTxt();
            setDescribeTxt();
         }
      }
      
      private function __pageBtnHandler(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case _preBtn:
               if(_current > 1)
               {
                  _current -= 1;
               }
               break;
            case _nextBtn:
               if(_current < _total)
               {
                  _current += 1;
               }
               break;
            case _firstBtn:
               _current = 1;
               break;
            case _lastBtn:
               _current = _total;
         }
         setBtnState();
         refreshCells();
      }
      
      private function setBtnState() : void
      {
         _preBtn.enable = _current > 1;
         _firstBtn.enable = _current > 1;
         _nextBtn.enable = _current < _total;
         _lastBtn.enable = _current < _total;
         if(_total < 1)
         {
            _total = 1;
         }
         _pageTxt.text = _current + "/" + _total;
      }
      
      public function setBuyVisible(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            if(_itemList[_loc2_].furniture)
            {
               _itemList[_loc2_].setBuyVisible(param1);
            }
            _loc2_++;
         }
      }
      
      private function get furnitureList() : Vector.<FurnitureTempInfo>
      {
         var _loc1_:Vector.<FurnitureTempInfo> = new Vector.<FurnitureTempInfo>();
         var _loc2_:Dictionary = TempleteManager.instance.furnitureTemplateCate.getTemplates();
         if(_typeView)
         {
            for each(var _loc3_:FurnitureTempInfo in _loc2_)
            {
               if(_loc3_.FurnitureType == _typeView.showType)
               {
                  _loc1_.push(_loc3_);
               }
            }
         }
         return _loc1_;
      }
      
      private function get model() : HomeModel
      {
         return HomeManager.instance.model;
      }
      
      private function get inHome() : Boolean
      {
         return WorldBossHelper.checkInHome(CampaignManager.instance.mapId);
      }
      
      private function get inHouse() : Boolean
      {
         return WorldBossHelper.checkInHouse(CampaignManager.instance.mapId);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

