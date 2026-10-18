package christmas
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.christmas.ChristmasModel;
   import yishi.datas.templates.ChristmasLotteryTempInfo;
   import yishi.manager.ChristmasManager;
   
   public class ChristmasRewardItem extends Sprite implements Disposeable
   {
      
      private var _leftIcon:Bitmap;
      
      private var _rightIcon:Bitmap;
      
      private var _txt:GradientText;
      
      private var _hBox:HBox;
      
      private var _index:int;
      
      public function ChristmasRewardItem(param1:int)
      {
         super();
         _index = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _leftIcon = ComponentFactory.Instance.creatBitmap("asset.ChristmasRewardItem.leftIcon");
         _rightIcon = ComponentFactory.Instance.creatBitmap("asset.ChristmasRewardItem.rightIcon");
         _txt = ComponentFactory.Instance.creatComponentByStylename("christmasRewardItem.txt");
         _hBox = ComponentFactory.Instance.creatCustomObject("christmasRewardItem.hBox");
         addChild(_leftIcon);
         addChild(_rightIcon);
         addChild(_txt);
         addChild(_hBox);
         _txt.text = LanguageMgr.GetTranslation("christmasRewardItem.txt" + _index);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function refreshData(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc4_:ChristmasLotteryTempInfo = null;
         var _loc2_:ChristmasRewardIconItem = null;
         _hBox.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            if(_loc4_)
            {
               _loc2_ = new ChristmasRewardIconItem();
               _loc2_.data = _loc4_;
               if(_index == 1 || _index == 2 || _index == 3)
               {
                  _loc2_.isPlay = true;
               }
               _hBox.addChild(_loc2_);
            }
            _loc3_++;
         }
         _hBox.commitChanges();
         _hBox.x = 400 - (_hBox.numChildren - 1) * 30;
      }
      
      public function refreshView() : void
      {
      }
      
      private function get model() : ChristmasModel
      {
         return ChristmasManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_leftIcon);
         _leftIcon = null;
         ObjectUtils.disposeObject(_rightIcon);
         _rightIcon = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeAllChildren(_hBox);
         _hBox = null;
      }
   }
}

