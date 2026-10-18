package mvc.module.sort
{
   import com.pickgliss.ui.controls.cell.INotSameHeightListCellData;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.card.MagicCardFightInfo;
   import mvc.module.children.ChildData;
   import mvc.module.pet.PetData;
   
   public class SortData implements INotSameHeightListCellData
   {
      
      public var orderId:int;
      
      public var grades:int;
      
      public var HideFashion:Boolean;
      
      public var gp:Number;
      
      public var consortiaLevel:int;
      
      public var consortiaFightPower:Number;
      
      public var fightCapacity:int;
      
      public var multipleCapacity:int;
      
      public var offer:int;
      
      public var nikcName:String;
      
      public var consortiaName:String;
      
      public var selfHonour:int;
      
      public var charms:int;
      
      public var soulScore:int;
      
      public var army:BaseArmy;
      
      public var pvpScore:int;
      
      public var serverName:String = "";
      
      public var regressTime:String = "";
      
      public var petData:PetData;
      
      public var cardFightInfoList:Vector.<MagicCardFightInfo>;
      
      public var childData:ChildData;
      
      public var activeMagicCards:Array = [];
      
      public var uuid:String = "";
      
      public function SortData()
      {
         super();
         army = new BaseArmy();
      }
      
      public function getCellHeight() : Number
      {
         return 33;
      }
   }
}

