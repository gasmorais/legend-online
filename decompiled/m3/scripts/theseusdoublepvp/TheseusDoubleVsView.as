package theseusdoublepvp
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import managers.TheseusPvpManager;
   import mvc.module.theseusdoublepvp.TheseusDoublePvpModel;
   import theseusdoublepvp.item.TheseusVsBlue;
   import theseusdoublepvp.item.TheseusVsRed;
   
   public class TheseusDoubleVsView extends Sprite implements IManualSize
   {
      
      protected var _VsBg:Bitmap;
      
      protected var _blueitem1:TheseusVsBlue;
      
      protected var _blueitem2:TheseusVsBlue;
      
      protected var _blueitem3:TheseusVsBlue;
      
      protected var _blueitem4:TheseusVsBlue;
      
      protected var _matchsuccessfully:Bitmap;
      
      protected var _reditem1:TheseusVsRed;
      
      protected var _reditem2:TheseusVsRed;
      
      protected var _reditem3:TheseusVsRed;
      
      protected var _reditem4:TheseusVsRed;
      
      protected var _Vs:Bitmap;
      
      protected var _blue:Array = [];
      
      protected var _red:Array = [];
      
      public function TheseusDoubleVsView()
      {
         super();
         initView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,852,574);
      }
      
      protected function initView() : void
      {
         _VsBg = ComponentFactory.Instance.creatBitmap("asset.theseuspve.double.VsBg");
         _blueitem1 = ComponentFactory.Instance.creatCustomObject("ui.theseuepvp.blueitem1");
         _blueitem2 = ComponentFactory.Instance.creatCustomObject("ui.theseuepvp.blueitem2");
         _blueitem3 = ComponentFactory.Instance.creatCustomObject("ui.theseuepvp.blueitem3");
         _blueitem4 = ComponentFactory.Instance.creatCustomObject("ui.theseuepvp.blueitem4");
         _matchsuccessfully = ComponentFactory.Instance.creatBitmap("asset.theseuspve.double.matchsuccessfully");
         _reditem1 = ComponentFactory.Instance.creatCustomObject("ui.theseuepvp.reditem1");
         _reditem2 = ComponentFactory.Instance.creatCustomObject("ui.theseuepvp.reditem2");
         _reditem3 = ComponentFactory.Instance.creatCustomObject("ui.theseuepvp.reditem3");
         _reditem4 = ComponentFactory.Instance.creatCustomObject("ui.theseuepvp.reditem4");
         _Vs = ComponentFactory.Instance.creatBitmap("asset.theseuspve.double.Vs");
         _blue = [_blueitem1,_blueitem2,_blueitem3,_blueitem4];
         _red = [_reditem1,_reditem2,_reditem3,_reditem4];
         addChild(_VsBg);
         addChild(_blueitem1);
         addChild(_blueitem2);
         addChild(_blueitem3);
         addChild(_blueitem4);
         addChild(_matchsuccessfully);
         addChild(_reditem1);
         addChild(_reditem2);
         addChild(_reditem3);
         addChild(_reditem4);
         addChild(_Vs);
      }
      
      public function show() : void
      {
         refreshView();
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 4;
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _blue[_loc1_].data = model.matchSelfInfoArr[_loc1_];
            _red[_loc1_].data = model.matchOtherInfoArr[_loc1_];
            _loc1_++;
         }
      }
      
      private function get model() : TheseusDoublePvpModel
      {
         return TheseusPvpManager.Instance.model1;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_VsBg);
         _VsBg = null;
         ObjectUtils.disposeObject(_blueitem1);
         _blueitem1 = null;
         ObjectUtils.disposeObject(_blueitem2);
         _blueitem2 = null;
         ObjectUtils.disposeObject(_blueitem3);
         _blueitem3 = null;
         ObjectUtils.disposeObject(_blueitem4);
         _blueitem4 = null;
         ObjectUtils.disposeObject(_matchsuccessfully);
         _matchsuccessfully = null;
         ObjectUtils.disposeObject(_reditem1);
         _reditem1 = null;
         ObjectUtils.disposeObject(_reditem2);
         _reditem2 = null;
         ObjectUtils.disposeObject(_reditem3);
         _reditem3 = null;
         ObjectUtils.disposeObject(_reditem4);
         _reditem4 = null;
         ObjectUtils.disposeObject(_Vs);
         _Vs = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

