package map.campaign.view.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class RaceAgainstTimeView extends Sprite implements Disposeable
   {
      
      private static const CLEAR:int = 1;
      
      private static const TIME:int = 2;
      
      private var _bg:ScaleBitmapImage;
      
      private var _back:MutipleImage;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _scrollPanel2:ScrollPanel;
      
      private var _clearVBox:VBox;
      
      private var _timeVBox:VBox;
      
      public function RaceAgainstTimeView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("raceAgainstTimeView.bg");
         _back = ComponentFactory.Instance.creatComponentByStylename("raceAgainstTimeView.back");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("raceAgainstTimeView.scrollPanel");
         _scrollPanel2 = ComponentFactory.Instance.creatComponentByStylename("raceAgainstTimeView.scrollPanel2");
         _clearVBox = ComponentFactory.Instance.creatComponentByStylename("raceAgainstTimeView.clearVBox");
         _timeVBox = ComponentFactory.Instance.creatComponentByStylename("raceAgainstTimeView.timeVBox");
         addChild(_bg);
         addChild(_back);
         addChild(_scrollPanel);
         addChild(_scrollPanel2);
         initClearVBox();
         initTimeVBox();
      }
      
      private function initClearVBox() : void
      {
         var _loc4_:int = 0;
         var _loc2_:RaceAgainstTimeItem = null;
         var _loc5_:int = 0;
         var _loc6_:SimpleDictionary = TempleteManager.instance.raceAgainstTimeDropTempCate.getRewardList(1);
         var _loc1_:Array = _loc6_.keys.reverse();
         var _loc3_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc4_ = int(_loc1_[_loc5_]);
            _loc3_ = _loc6_[_loc4_];
            _loc2_ = new RaceAgainstTimeItem();
            _loc2_.setClearRewards(_loc4_,_loc3_);
            _clearVBox.addChild(_loc2_);
            _loc5_++;
         }
         _scrollPanel.setView(_clearVBox);
         _scrollPanel.invalidateViewport();
         _scrollPanel.commitChanges();
      }
      
      private function initTimeVBox() : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:RaceAgainstTimeItem = null;
         var _loc4_:int = 0;
         var _loc7_:SimpleDictionary = TempleteManager.instance.raceAgainstTimeDropTempCate.getRewardList(2);
         var _loc1_:Array = _loc7_.keys.sort(16);
         var _loc3_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc5_ = int(_loc1_[_loc4_]);
            _loc3_ = _loc7_[_loc5_];
            _loc6_ = int(_loc1_[_loc4_ - 1] ? _loc1_[_loc4_ - 1] : 0);
            _loc2_ = new RaceAgainstTimeItem();
            _loc2_.setTimeRewards(_loc6_,_loc5_,_loc3_);
            _timeVBox.addChild(_loc2_);
            _loc4_++;
         }
         _scrollPanel2.setView(_timeVBox);
         _scrollPanel2.invalidateViewport();
         _scrollPanel2.commitChanges();
      }
      
      private function clear() : void
      {
         for each(var _loc1_:RaceAgainstTimeItem in _clearVBox)
         {
            _loc1_.dispose();
         }
         for each(var _loc2_:RaceAgainstTimeItem in _timeVBox)
         {
            _loc2_.dispose();
         }
      }
      
      public function dispose() : void
      {
         clear();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_scrollPanel2);
         _scrollPanel2 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

