package mvc.module.armyII
{
   import com.road.yishi.proto.army.BasePropertiesMsg;
   
   public class BasePropertysInfo
   {
      
      public var power:int;
      
      public var agility:int;
      
      public var intel:int;
      
      public var physi:int;
      
      public var captain:int;
      
      public var attack:int;
      
      public var defence:int;
      
      public var magicattack:int;
      
      public var magicdefence:int;
      
      public var live:int;
      
      public var conat:int;
      
      public var forcehit:int;
      
      public var parry:int;
      
      private var _isChange:Boolean;
      
      public function BasePropertysInfo()
      {
         super();
      }
      
      public function readData(param1:BasePropertiesMsg) : void
      {
         if(!param1)
         {
            return;
         }
         _isChange = false;
         if(power != param1.power)
         {
            power = param1.power;
            _isChange = true;
         }
         if(agility != param1.agility)
         {
            agility = param1.agility;
            _isChange = true;
         }
         if(intel != param1.intel)
         {
            intel = param1.intel;
            _isChange = true;
         }
         if(physi != param1.physi)
         {
            physi = param1.physi;
            _isChange = true;
         }
         if(captain != param1.captain)
         {
            captain = param1.captain;
            _isChange = true;
         }
         if(attack != param1.attack)
         {
            attack = param1.attack;
            _isChange = true;
         }
         if(defence != param1.defence)
         {
            defence = param1.defence;
            _isChange = true;
         }
         if(magicattack != param1.magicattack)
         {
            magicattack = param1.magicattack;
            _isChange = true;
         }
         if(magicdefence != param1.magicdefence)
         {
            magicdefence = param1.magicdefence;
            _isChange = true;
         }
         if(live != param1.live)
         {
            live = param1.live;
            _isChange = true;
         }
         if(conat != param1.conat)
         {
            conat = param1.conat;
            _isChange = true;
         }
         if(forcehit != param1.forcehit)
         {
            forcehit = param1.forcehit;
            _isChange = true;
         }
         if(parry != param1.parry)
         {
            parry = param1.parry;
            _isChange = true;
         }
      }
      
      public function get isChange() : Boolean
      {
         return _isChange;
      }
   }
}

