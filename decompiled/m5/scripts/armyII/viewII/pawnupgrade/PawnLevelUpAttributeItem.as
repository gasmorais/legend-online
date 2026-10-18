package armyII.viewII.pawnupgrade
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mvc.module.armyII.ArmyPawn;
   
   public class PawnLevelUpAttributeItem extends Sprite implements Disposeable
   {
      
      public static const LEVEL:String = "level";
      
      public static const PHYSICAL_ATTACK:String = "physicalAttack";
      
      public static const MAGIC_ATTACK:String = "magicAttack";
      
      public static const PHYSICAL_DEFENCE:String = "physicalDefence";
      
      public static const MAGIC_DEFENCE:String = "magicDefence";
      
      public static const FORCE_HIT:String = "forceHit";
      
      public static const LIVE:String = "live";
      
      private var _name:Bitmap;
      
      private var _increseImg:Bitmap;
      
      private var _preValue:FilterFrameText;
      
      private var _additionValue:FilterFrameText;
      
      private var _canUpgrade:Boolean;
      
      public function PawnLevelUpAttributeItem(param1:String)
      {
         super();
         initView(param1);
      }
      
      private function initView(param1:String) : void
      {
         _name = ComponentFactory.Instance.creatBitmap("asset.armyII.PawnLevelUpAttribute." + param1);
         _increseImg = ComponentFactory.Instance.creatBitmap("asset.armyII.PawnLevelUpIncress");
         _preValue = ComponentFactory.Instance.creatComponentByStylename("armyII.PreTxt");
         _additionValue = ComponentFactory.Instance.creatComponentByStylename("armyII.AddTxt");
         addChild(_name);
         addChild(_increseImg);
         _increseImg.visible = false;
         addChild(_preValue);
         addChild(_additionValue);
      }
      
      public function set currentValue(param1:String) : void
      {
         _preValue.text = param1;
      }
      
      public function setData(param1:ArmyPawn, param2:String) : void
      {
         var _loc3_:ArmyPawn = null;
         _preValue.text = param1[param2].toString();
         if(param1.nextTemplate)
         {
            _canUpgrade = true;
            _loc3_ = new ArmyPawn();
            _loc3_.templateId = param1.nextTemplate.TemplateId;
            _loc3_.attributeDic = param1.attributeDic;
            _additionValue.text = (_loc3_[param2] - param1[param2]).toString();
            _additionValue.visible = false;
            _increseImg.visible = false;
            _increseImg.x = _preValue.x + _preValue.textWidth + 10;
            _additionValue.x = _increseImg.x + _increseImg.width - 5;
         }
         else
         {
            _canUpgrade = false;
         }
      }
      
      public function showUpgrade() : void
      {
         if(_canUpgrade)
         {
            _increseImg.visible = true;
            _additionValue.visible = true;
         }
      }
      
      public function hideUpgrade() : void
      {
         _increseImg.visible = false;
         _additionValue.visible = false;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

