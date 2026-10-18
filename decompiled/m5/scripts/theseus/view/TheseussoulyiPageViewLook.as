package theseus.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.theseus.TheseusWarsoulItemInfo;
   import mvc.module.theseus.TheseusYiCellInfo;
   import mvc.module.theseus.TheseussoulModel;
   import theseus.item.TheseussouYiCell;
   import theseus.item.TheseussoulYiItemLook;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.TheseusRageTempInfo;
   import yishi.manager.TempleteManager;
   
   public class TheseussoulyiPageViewLook extends Sprite
   {
      
      public var _YiBg:Bitmap;
      
      public var _chooseTxt:GradientText;
      
      public var _item:TheseussoulYiItemLook;
      
      private var _bagBack:Scale9CornerImage;
      
      private var _cellList:Vector.<TheseussouYiCell>;
      
      private var _currSelectIdx:int = 1;
      
      private var _gInfo:GoodsInfo;
      
      private var _centerIcons:ScaleFrameImage;
      
      private const POSLIST:Array = [1,3,4,5,2,6,9,10,11,12,7,8];
      
      private var _thane:ThaneInfo;
      
      public function TheseussoulyiPageViewLook()
      {
         super();
         initView();
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
         var _loc5_:Array = null;
         var _loc6_:TheseusRageTempInfo = TempleteManager.instance.theseusRageTempCate.getOneTempInfo(param2,param1);
         if(_loc6_)
         {
            _loc5_ = param4.concat();
            _loc5_.unshift(_loc6_);
            _item.dataList = _loc5_;
            _chooseTxt.text = LanguageMgr.GetTranslation("theseus.equip.part" + param3) + "  Lv." + param1;
         }
      }
      
      private function initView() : void
      {
         _gInfo = new GoodsInfo();
         _YiBg = ComponentFactory.Instance.creatBitmap("asset.theseus.LookYiBg");
         _bagBack = ComponentFactory.Instance.creatComponentByStylename("ThereussoulEquipView.BagBack");
         _chooseTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.GT.lookchooseTxt");
         _item = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.lookItem",[1]);
         _centerIcons = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.lookyiCenterIcons");
         addChild(_bagBack);
         addChild(_YiBg);
         initCells();
         addChild(_chooseTxt);
         addChild(_item);
         addChild(_centerIcons);
      }
      
      public function initData(param1:ThaneInfo) : void
      {
         _thane = param1;
         initEvent();
         refreshView();
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
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.lookyiCell" + (_loc2_ + 1));
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
         var _loc1_:Array = null;
         var _loc8_:Array = null;
         var _loc4_:int = 0;
         var _loc10_:int = 0;
         var _loc7_:Array = _thane.theseusInfo.yiDic.getList();
         for each(var _loc9_:TheseusYiCellInfo in _loc7_)
         {
            _loc3_ = POSLIST.indexOf(_loc9_.pos);
            _loc2_ = _cellList[_loc3_];
            _loc2_.level = _loc9_.level;
            _loc2_.initAddLevel();
         }
         if(_thane.warSoulInfo)
         {
            _loc1_ = _thane.warSoulInfo.getEquipBodyList();
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
         }
         currSelectIdx = _currSelectIdx;
      }
      
      private function initEvent() : void
      {
         for each(var _loc1_:TheseussouYiCell in _cellList)
         {
            _loc1_.addEventListener("click",itemClickHandler);
            _loc1_.buttonMode = true;
         }
      }
      
      private function removeEvent() : void
      {
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
         ObjectUtils.disposeObject(_chooseTxt);
         _chooseTxt = null;
         ObjectUtils.disposeObject(_item);
         _item = null;
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

