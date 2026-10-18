package hallfame.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import funny.datas.FunnyBagData;
   import funny.datas.FunnyData;
   import funny.mountact.MountsAvatarView;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.NumberViewUtils;
   
   public class HallFameRightView extends Component
   {
      
      private var _data:FunnyBagData;
      
      private var mountTempArr:Array;
      
      private var currPage:int;
      
      private var totalPage:int;
      
      private var _mountView:MountsAvatarView;
      
      private var _bagItem:HallFameBagItem;
      
      private var _timeTxt:GradientText;
      
      private var _fightImg:Bitmap;
      
      private var _numberImg:BitmapData;
      
      private var _numberSp:Sprite;
      
      private var _lastPageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      public function HallFameRightView()
      {
         super();
         initView();
         initData();
         initEvent();
      }
      
      private function initView() : void
      {
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("hallfame.timeTxt");
         _fightImg = ComponentFactory.Instance.creatBitmap("asset.hallfame.fightImg");
         _numberImg = ComponentFactory.Instance.creatBitmapData("asset.hallfame.fightValue");
         _lastPageBtn = ComponentFactory.Instance.creatComponentByStylename("hallfame.lastBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("hallfame.nextBtn");
         _mountView = new MountsAvatarView();
         _mountView.x = 210;
         _mountView.y = 250;
         _bagItem = new HallFameBagItem();
         _bagItem.x = 20;
         _bagItem.y = 280;
         _numberSp = new Sprite();
         _numberSp.x = 188;
         _numberSp.y = 28;
         addChild(_timeTxt);
         addChild(_mountView);
         addChild(_fightImg);
         addChild(_numberSp);
         addChild(_lastPageBtn);
         addChild(_nextPageBtn);
         addChild(_bagItem);
      }
      
      private function initData() : void
      {
         var _loc5_:int = 0;
         var _loc3_:GoodsTemplateInfo = null;
         mountTempArr = [];
         var _loc4_:FunnyData = FunnyManager.instance.model.findDataByType(146);
         var _loc1_:Array = [];
         for each(var _loc6_:FunnyBagData in _loc4_.bagList)
         {
            _loc5_ = 1;
            while(_loc5_ < 5)
            {
               if(_loc5_ == 1)
               {
                  if(_loc6_.conditionList[0].bak != 0)
                  {
                     _loc1_.push(_loc6_.conditionList[0].bak);
                  }
               }
               else if(_loc6_.conditionList[0]["bak" + _loc5_] != 0)
               {
                  _loc1_.push(_loc6_.conditionList[0]["bak" + _loc5_]);
               }
               _loc5_++;
            }
         }
         for each(var _loc2_:int in _loc1_)
         {
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_);
            if(_loc3_.SonType == 218)
            {
               mountTempArr.push(TempleteManager.instance.mountTemplateDic[_loc3_.Property1]);
            }
         }
         currPage = 1;
         totalPage = mountTempArr.length;
         setButtonState();
         if(mountTempArr.length > 0)
         {
            _mountView.data = mountTempArr[0];
         }
         else
         {
            _mountView.data = null;
         }
      }
      
      private function initEvent() : void
      {
         _lastPageBtn.addEventListener("click",__onPageHandler);
         _nextPageBtn.addEventListener("click",__onPageHandler);
      }
      
      private function removeEvent() : void
      {
         _lastPageBtn.removeEventListener("click",__onPageHandler);
         _nextPageBtn.removeEventListener("click",__onPageHandler);
      }
      
      private function __onPageHandler(param1:MouseEvent) : void
      {
         if(param1.currentTarget == _lastPageBtn)
         {
            if(currPage > 1)
            {
               currPage = currPage - 1;
            }
         }
         else if(currPage < totalPage)
         {
            currPage = currPage + 1;
         }
         _mountView.data = mountTempArr[currPage - 1];
         setButtonState();
      }
      
      private function setButtonState() : void
      {
         _lastPageBtn.enable = currPage != 1;
         _nextPageBtn.enable = currPage != totalPage;
      }
      
      public function get data() : FunnyBagData
      {
         return _data;
      }
      
      public function set data(param1:FunnyBagData) : void
      {
         _data = param1;
         _bagItem.data = _data;
         refresh();
      }
      
      private function refresh() : void
      {
         var _loc2_:FunnyData = FunnyManager.instance.model.findDataByType(146);
         if(!_loc2_)
         {
            return;
         }
         var _loc1_:String = DateFormatter.transDate(_loc2_.startTime / 1000);
         var _loc3_:String = DateFormatter.transDate(_loc2_.endTime / 1000);
         _timeTxt.text = LanguageMgr.GetTranslation("funny.newyearact.NewYearPayActView.actTimeTxt",_loc1_,_loc3_);
         NumberViewUtils.refreshValue(_loc2_.finishNum,_numberSp,_numberImg,24,24,15,24,"0123456789");
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_mountView);
         _mountView = null;
         ObjectUtils.disposeObject(_lastPageBtn);
         _lastPageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_bagItem);
         _bagItem = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_fightImg);
         _fightImg = null;
         ObjectUtils.disposeObject(_numberImg);
         _numberImg = null;
         ObjectUtils.disposeObject(_numberSp);
         _numberSp = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

