package antaeus
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.antaeus.AntaeusShowData;
   import yishi.view.tips.BaseTip;
   
   public class AntaeusTip extends BaseTip
   {
      
      private var _bit0:Bitmap;
      
      private var _bit1:Bitmap;
      
      private var _txtTip1Name:FilterFrameText;
      
      private var _txtTip1Star:FilterFrameText;
      
      private var _txtTip1Item:FilterFrameText;
      
      private var _oriY:int;
      
      private var _count:int;
      
      private var _container:Component;
      
      public function AntaeusTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.antaeus.tip.line");
         _bit1 = ComponentFactory.Instance.creatBitmap("asset.antaeus.tip.line");
         _txtTip1Name = ComponentFactory.Instance.creatComponentByStylename("ui.antaeus.txtTip1Name");
         _txtTip1Star = ComponentFactory.Instance.creatComponentByStylename("ui.antaeus.txtTip1Star");
         addChild(_bit0);
         addChild(_txtTip1Name);
         _bit0.width = 180;
         _bit1.width = 180;
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:AntaeusShowData = null;
         var _loc2_:int = 0;
         if(tipData)
         {
            _oriY = 37;
            _count = 0;
            _loc1_ = tipData.data;
            _loc2_ = int(tipData.index);
            if(_container)
            {
               _container.dispose();
               _container = null;
            }
            if(_bit1.parent)
            {
               removeChild(_bit1);
               removeChild(_txtTip1Star);
            }
            _container = new Component();
            addChild(_container);
            if(_loc2_ == 1)
            {
               _txtTip1Name.text = LanguageMgr.GetTranslation("antaeus.tip1-0");
               createItem("antaeus.tip1-1",_loc1_.pet.petCap);
            }
            else if(_loc2_ == 2)
            {
               _txtTip1Name.text = LanguageMgr.GetTranslation("antaeus.tip2-0");
               createItem("antaeus.tip2-1",_loc1_.children.childrenCap);
            }
            else if(_loc2_ == 3)
            {
               _txtTip1Name.text = LanguageMgr.GetTranslation("antaeus.tip3-0");
               createItem("antaeus.tip3-1",_loc1_.slaveChild.slaveChildCap);
            }
            else if(_loc2_ == 4)
            {
               _txtTip1Name.text = LanguageMgr.GetTranslation("antaeus.tip4-0");
               createItem("antaeus.tip4-1",_loc1_.goddess.attack);
               createItem("antaeus.tip4-2",_loc1_.goddess.defance);
               createItem("antaeus.tip4-3",_loc1_.goddess.magicDefance);
               createItem("antaeus.tip4-4",_loc1_.goddess.live);
            }
            else if(_loc2_ == 5)
            {
               _txtTip1Name.text = LanguageMgr.GetTranslation("antaeus.tip5-0");
               createItem("antaeus.tip5-1",_loc1_.artifact.attack);
               createItem("antaeus.tip5-2",_loc1_.artifact.defences);
               createItem("antaeus.tip5-3",_loc1_.artifact.magicAttack);
               createItem("antaeus.tip5-4",_loc1_.artifact.magicDefences);
               createItem("antaeus.tip5-5",_loc1_.artifact.penetrate);
               createItem("antaeus.tip5-6",_loc1_.artifact.parry);
               createItem("antaeus.tip5-7",_loc1_.artifact.live);
            }
            else if(_loc2_ == 6)
            {
               addChild(_bit1);
               addChild(_txtTip1Star);
               _bit1.y = _txtTip1Star.y + 23;
               _txtTip1Star.text = LanguageMgr.GetTranslation("antaeus.tip6-00",int(_loc1_.titan.starLevel / 10),_loc1_.titan.starLevel % 10);
               _oriY = 67;
               _txtTip1Name.text = LanguageMgr.GetTranslation("antaeus.tip6-0");
               createItem("antaeus.tip6-1",_loc1_.titan.reduceResi);
               createItem("antaeus.tip6-2",_loc1_.titan.fireResi);
               createItem("antaeus.tip6-3",_loc1_.titan.waterResi);
               createItem("antaeus.tip6-4",_loc1_.titan.windResi);
               createItem("antaeus.tip6-5",_loc1_.titan.electResi);
               createItem("antaeus.tip6-6",_loc1_.titan.lightResi);
               createItem("antaeus.tip6-7",_loc1_.titan.darkResi);
               _count = _count + 1;
            }
            _bg.y = -10;
            _bg.height = 60 + _count * 20;
            _bit0.width = _bit1.width = _bg.width = 220;
         }
      }
      
      private function createItem(param1:String, param2:Number) : void
      {
         _txtTip1Item = ComponentFactory.Instance.creatComponentByStylename("ui.antaeus.txtTip1Item");
         _container.addChild(_txtTip1Item);
         _txtTip1Item.y = _oriY + _count * 20;
         _count = _count + 1;
         _txtTip1Item.htmlText = LanguageMgr.GetTranslation(param1,param2);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(_bit1);
         _bit1 = null;
         ObjectUtils.disposeObject(_txtTip1Name);
         _txtTip1Name = null;
         ObjectUtils.disposeObject(_txtTip1Star);
         _txtTip1Star = null;
         ObjectUtils.disposeObject(_txtTip1Item);
         _txtTip1Item = null;
         ObjectUtils.disposeObject(_container);
         _container = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

