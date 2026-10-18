package theseus.war.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import theseus.war.mediator.TheseusWarMetrailCellClickMediator;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.MediatorMananger;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   
   public class TheseusWarMetrailCell extends Sprite
   {
      
      public var _intensifyMeTxt:FilterFrameText;
      
      public var _warIntensifyMeIcon:BaseItemView;
      
      private var _bg:Bitmap;
      
      private var _data:GoodsInfo;
      
      public var sonType:int;
      
      public var bagType:int;
      
      public var objectId:int;
      
      public var pos:int;
      
      public var isNeedMediator:Boolean;
      
      private var _isRigist:Boolean;
      
      protected var _mediatorKey:String;
      
      public const NAME:String = "theseus.war.item.TheseusWarMetrailCell";
      
      public var isVisalBag:Boolean = false;
      
      private var _isEnough:Boolean = false;
      
      public function TheseusWarMetrailCell()
      {
         super();
         initView();
      }
      
      public function get data() : GoodsInfo
      {
         return _data;
      }
      
      public function get isEnough() : Boolean
      {
         return _isEnough;
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         _data = param1;
         _warIntensifyMeIcon.data = _data;
         if(_data)
         {
            if(isVisalBag)
            {
               _warIntensifyMeIcon.setItemTextOther(getCountStr(_data.count) + "/" + 1);
            }
            else
            {
               this.updateDataCount();
            }
         }
         else
         {
            _isEnough = false;
         }
         if(isNeedMediator && !_isRigist && _data)
         {
            registerMediator();
         }
      }
      
      public function updateDataCount() : void
      {
         var _loc1_:int = 0;
         if(_data)
         {
            _loc1_ = int(GoodsManager.instance.getGoodsNumByTempId(_data.templateId));
            _warIntensifyMeIcon.setItemTextOther(getCountStr(_loc1_) + "/" + getCountStr(_data.count));
            _isEnough = _loc1_ >= _data.count;
         }
      }
      
      protected function getCountStr(param1:int) : String
      {
         if(param1 <= 0)
         {
            return "0";
         }
         var _loc2_:Number = param1 / 10000;
         if(param1 % 10000 == 0)
         {
            if(_loc2_ >= 1 && _loc2_ < 100)
            {
               return int(_loc2_ * 10) + "K";
            }
            return (_loc2_ / 100).toFixed(1) + "M";
         }
         if(_loc2_ >= 1 && _loc2_ < 10)
         {
            return int(_loc2_ * 10) + "K";
         }
         if(_loc2_ > 10 && _loc2_ < 100)
         {
            return int(_loc2_ * 10) + "K";
         }
         if(_loc2_ >= 100)
         {
            return (_loc2_ / 100).toFixed(1) + "M";
         }
         return param1.toString();
      }
      
      protected function registerMediator() : void
      {
         _isRigist = true;
         var _loc1_:Array = [TheseusWarMetrailCellClickMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"theseus.war.item.TheseusWarMetrailCell");
      }
      
      protected function unregisterMediator() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
      }
      
      public function get icon() : BaseIconView
      {
         return _warIntensifyMeIcon.icon;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.theseus.warBoxBg");
         _intensifyMeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.intensifyMeTxt");
         _warIntensifyMeIcon = ComponentFactory.Instance.creatCustomObject("theseuswar.ins.MetrailItemView");
         addChild(_bg);
         addChild(_intensifyMeTxt);
         addChild(_warIntensifyMeIcon);
         _intensifyMeTxt.text = LanguageMgr.GetTranslation("theesus.war.intensifyCL");
      }
      
      public function set defaultMeTxt(param1:String) : void
      {
         _intensifyMeTxt.text = param1;
      }
      
      public function dispose() : void
      {
         unregisterMediator();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_intensifyMeTxt);
         _intensifyMeTxt = null;
         ObjectUtils.disposeObject(_warIntensifyMeIcon);
         _warIntensifyMeIcon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

