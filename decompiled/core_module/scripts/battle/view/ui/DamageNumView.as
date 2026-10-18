package battle.view.ui
{
   import battle.BattleManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import yishi.utils.FormularySets;
   
   public class DamageNumView extends Sprite
   {
      
      public static const STEP:Number = 99999;
      
      private var _pic:Sprite;
      
      private var _n:int;
      
      private var _type:int;
      
      private var _isAdd:Boolean;
      
      private var add:Boolean = true;
      
      private var tmp:int = 0;
      
      private var _selfCause:Boolean;
      
      private var _isParry:Boolean;
      
      private var _isCitical:Boolean = false;
      
      private var _isFire:Boolean;
      
      private var _animationMC:MovieClip;
      
      private var _greenNumber:BitmapData;
      
      private var _selfParryDamageNumber:BitmapData;
      
      private var _selfDamageNumber:BitmapData;
      
      private var _otherDamageNumber:BitmapData;
      
      private var _parry:Bitmap;
      
      private var _criticalDamageNumber:BitmapData;
      
      private var _critical:Bitmap;
      
      private var _fireFlg:Bitmap;
      
      private var _txtView:DisplayObject;
      
      private var _numSp:Sprite;
      
      public function DamageNumView(param1:int, param2:int = 1, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false)
      {
         super();
         _n = param1;
         _type = param2;
         _isAdd = param3;
         _selfCause = param4;
         _isParry = param5;
         _isFire = param6;
         if(_type == 2)
         {
            _animationMC = ComponentFactory.Instance.creat("asset.battle.BloodUpdateRage");
         }
         else
         {
            _animationMC = ComponentFactory.Instance.creat("asset.battle.BloodUpdateAsset");
         }
         _parry = ComponentFactory.Instance.creatBitmap("asset.battle.ParryAsset") as Bitmap;
         _pic = getPercent(param1);
         _animationMC.stop();
         _animationMC.container.addChild(_pic);
         addChild(_animationMC);
         addEventListener("addedToStage",__addToStage);
      }
      
      public function get key() : String
      {
         return _type.toString() + _isAdd + _selfCause + _isParry;
      }
      
      private function dispose() : void
      {
         removeEventListener("addedToStage",__addToStage);
         _animationMC.addFrameScript(_animationMC.totalFrames - 1,null);
         ObjectUtils.disposeViolentMc(_animationMC);
         _animationMC = null;
         ObjectUtils.disposeObject(_parry);
         _parry = null;
         ObjectUtils.disposeObject(_criticalDamageNumber);
         _criticalDamageNumber = null;
         ObjectUtils.disposeObject(_critical);
         _critical = null;
         ObjectUtils.disposeObject(_fireFlg);
         _fireFlg = null;
         ObjectUtils.disposeViolentMc(_pic);
         ObjectUtils.disposeAllChildren(_numSp);
         _pic = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function updateData(param1:int, param2:int = 1, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false) : void
      {
         _n = param1;
         _type = param2;
         _isAdd = param3;
         _selfCause = param4;
         _isParry = param5;
         addEventListener("addedToStage",__addToStage);
         if(_animationMC != null)
         {
            _animationMC.gotoAndPlay(1);
         }
         if(_txtView != null)
         {
            getPercent(_n);
         }
      }
      
      private function playEnd() : void
      {
         if(_isCitical)
         {
            BattleManager.criticalNum--;
            _isCitical = false;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         dispose();
      }
      
      private function __addToStage(param1:Event) : void
      {
         removeEventListener("addedToStage",__addToStage);
         if(_pic == null)
         {
            dispose();
            return;
         }
         _animationMC.addFrameScript(_animationMC.totalFrames - 1,playEnd);
         _animationMC.stop();
         if(BattleManager.criticalNum > 1 && _isCitical)
         {
            _pic.x = -_pic.width / 2 + 120 * getRandomNum();
            _pic.y = -_pic.height / 2 + 60 * getRandomNum();
         }
         else
         {
            _pic.x = -_pic.width / 2;
            if(_isAdd)
            {
               _pic.y = -_pic.height / 2 - 20;
            }
            else
            {
               _pic.y = -_pic.height / 2;
            }
         }
         _animationMC.gotoAndPlay(1);
      }
      
      public function getPercent(param1:int) : Sprite
      {
         if(_numSp == null)
         {
            _numSp = new Sprite();
         }
         if(_isAdd)
         {
            if(_txtView == null)
            {
               _txtView = ComponentFactory.Instance.creatComponentByStylename("battle.GreenNumberAssetSp.text");
            }
            (_txtView as FilterFrameText).text = FormularySets.toStringByNum(param1,99999);
            _txtView.width = (_txtView as FilterFrameText).textWidth + 50;
            _numSp.addChild(_txtView);
         }
         else
         {
            if(_type == 1)
            {
               if(_selfCause)
               {
                  if(_isParry)
                  {
                     if(_txtView == null)
                     {
                        _txtView = ComponentFactory.Instance.creatComponentByStylename("battle.SelfCauseNumberAssetSp.text");
                     }
                  }
                  else if(_txtView == null)
                  {
                     _txtView = ComponentFactory.Instance.creatComponentByStylename("battle.DamageNumberAssetSp.text");
                  }
               }
               else if(_isParry)
               {
                  if(_txtView == null)
                  {
                     _txtView = ComponentFactory.Instance.creatComponentByStylename("battle.SelfCauseNumberAssetSp.text");
                  }
               }
               else if(_txtView == null)
               {
                  _txtView = ComponentFactory.Instance.creatComponentByStylename("battle.RedNumberAssetSp.text");
               }
               (_txtView as FilterFrameText).text = FormularySets.toStringByNum(param1,99999);
               _txtView.width = (_txtView as FilterFrameText).textWidth + 50;
               _numSp.addChild(_txtView);
               if(_isParry)
               {
                  _parry.x = (_txtView as FilterFrameText).textWidth + 10;
                  _parry.y = 6;
               }
               if(_isFire)
               {
                  if(_fireFlg == null)
                  {
                     _fireFlg = ComponentFactory.Instance.creatBitmap("asset.battle.fireImg");
                  }
                  _numSp.addChild(_fireFlg);
                  _fireFlg.x = _txtView.x - 45;
                  _fireFlg.y = -9;
               }
            }
            else
            {
               if(_txtView == null)
               {
                  _txtView = ComponentFactory.Instance.creatCustomObject("battle.CriticalDamageNumAssetSp");
               }
               _txtView["txt"].text = FormularySets.toStringByNum(param1,99999);
               if(_txtView["txt"].width < _txtView["txt"].textWidth)
               {
                  _txtView["txt"].width = _txtView["txt"].textWidth + 80;
               }
               _numSp.addChild(_txtView);
               _numSp.width = _txtView["txt"].width;
               if(_critical == null)
               {
                  _critical = ComponentFactory.Instance.creat("asset.battle.CriticalDamageAsset") as Bitmap;
               }
               _critical.x = _numSp.width - 22;
               _critical.y = 15;
               _numSp.width = _critical.x + _critical.width;
               if(_isParry)
               {
                  _parry.x = _critical.x + _critical.width - 20;
                  _parry.y = _critical.y + _critical.height;
               }
               BattleManager.criticalNum++;
               _isCitical = true;
            }
            if(_isParry)
            {
               _txtView.scaleX = 0.6;
               _txtView.scaleY = 0.6;
            }
            else
            {
               _txtView.scaleX = 1;
               _txtView.scaleY = 1;
            }
         }
         return _numSp;
      }
      
      private function getRandomNum() : Number
      {
         var _loc1_:Number = Math.random();
         if(_loc1_ < 0.5)
         {
            _loc1_ = -1;
         }
         else
         {
            _loc1_ = 1;
         }
         return _loc1_ * Math.random();
      }
   }
}

