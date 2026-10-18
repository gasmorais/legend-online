package managers
{
   import com.road.yishi.proto.fashion.FashionBook;
   import com.road.yishi.proto.fashion.FashionMsg;
   import com.road.yishi.proto.fashion.FashionPolishMsg;
   import com.road.yishi.proto.fashion.FashionPolishRequestMsg;
   import com.road.yishi.proto.fashion.PolishInfoMsg;
   import events.FashionEvent;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mvc.module.fashion.FashionInfo;
   import mvc.module.fashion.FashionModel;
   import mvc.module.fashion.FashionPolishInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   
   public class FashionManager extends EventDispatcher
   {
      
      private static var _instance:FashionManager;
      
      public function FashionManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : FashionManager
      {
         if(!_instance)
         {
            _instance = new FashionManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4542,__receivedBookHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 408,__receivedPolishHandler);
         getFashionBook();
         getFashionPolish(1,0,1);
      }
      
      public function getFashionBook() : void
      {
         var _loc1_:PackageOut = new PackageOut(8625);
         SocketManager.instance.socket.sendProtobuffer(_loc1_,null);
      }
      
      public function getFashionPolish(param1:int, param2:int = 0, param3:int = 2) : void
      {
         var _loc5_:PackageOut = new PackageOut(9635);
         var _loc4_:FashionPolishRequestMsg = new FashionPolishRequestMsg();
         _loc4_.op = param3;
         _loc4_.count = param2;
         _loc4_.sontype = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      private function __receivedBookHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:FashionBook = null;
         var _loc11_:FashionInfo = null;
         var _loc6_:int = 0;
         var _loc9_:GoodsTemplateInfo = null;
         var _loc7_:int = 0;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:FashionMsg = new FashionMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as FashionMsg;
         for(var _loc10_:String in fashionModel.bookList)
         {
            fashionModel.bookList[_loc10_] = null;
            delete fashionModel.bookList[_loc10_];
         }
         fashionModel.identityedList.length = 0;
         var _loc4_:int = int(_loc2_.info.length);
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = _loc2_.info[_loc6_] as FashionBook;
            _loc11_ = new FashionInfo();
            _loc11_.fashionTempId = _loc5_.tempId;
            _loc11_.appraisalSkill = _loc5_.appraisalSkill;
            _loc11_.isSwitch = _loc5_.isSwitch;
            fashionModel.bookList.add(_loc5_.tempId,_loc5_.isSwitch);
            if(_loc11_.appraisalSkill != 0)
            {
               fashionModel.identityedList.push(_loc11_);
            }
            _loc6_++;
         }
         var _loc12_:int = int(_loc2_.fashionIds.length);
         var _loc3_:Vector.<int> = new Vector.<int>();
         _loc7_ = 0;
         while(_loc7_ < _loc12_)
         {
            _loc9_ = temp(_loc2_.fashionIds[_loc7_]);
            if(_loc9_)
            {
               if(fashionModel.bookList[_loc2_.fashionIds[_loc7_]] != null || _loc9_.Property3 != 1)
               {
                  _loc3_.push(_loc2_.fashionIds[_loc7_]);
               }
            }
            _loc7_++;
         }
         _loc3_.sort(fashionSortById);
         fashionModel.fashionIds = _loc3_;
         dispatchEvent(new FashionEvent("FASHION_BOOK_RECEIVE",null));
      }
      
      private function __receivedPolishHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:FashionPolishInfo = null;
         var _loc7_:PolishInfoMsg = null;
         var _loc4_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:FashionPolishMsg = new FashionPolishMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as FashionPolishMsg;
         fashionModel.polishList.length = 0;
         var _loc3_:int = int(_loc2_.polishs.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc7_ = _loc2_.polishs[_loc4_] as PolishInfoMsg;
            _loc5_ = new FashionPolishInfo();
            _loc5_.sonType = _loc7_.sontype;
            _loc5_.exp = _loc7_.exp;
            _loc5_.level = _loc7_.level;
            fashionModel.polishList.push(_loc5_);
            _loc4_ += 1;
         }
         dispatchEvent(new FashionEvent("FASHION_REFRESH_RECEIVE",null));
      }
      
      private function temp(param1:int) : GoodsTemplateInfo
      {
         return TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1);
      }
      
      private function fashionSortById(param1:int, param2:int) : int
      {
         if(param1 > param2)
         {
            return -1;
         }
         if(param1 == param2)
         {
            return 0;
         }
         return 1;
      }
      
      public function saveBook(param1:int) : void
      {
         if(param1 == 0)
         {
            return;
         }
         var _loc3_:PackageOut = new PackageOut(8595);
         var _loc2_:FashionMsg = new FashionMsg();
         _loc2_.templateId = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function identityBook(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8781);
         var _loc2_:FashionMsg = new FashionMsg();
         _loc2_.templateId = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      public function get fashionIdentityProgress() : int
      {
         var _loc1_:ThaneInfo = ArmyManager.instance.thane;
         if(_loc1_.grades < 27)
         {
            return 10000;
         }
         if(fashionModel.identityedList.length > 0)
         {
            return 10000;
         }
         return SharedManager.instance.fashionIdentityProgress;
      }
      
      public function disenableNewIcon(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8631);
         var _loc2_:FashionMsg = new FashionMsg();
         _loc2_.templateId = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function getSonTypeByindex(param1:int) : int
      {
         var _loc2_:int = 0;
         switch(param1)
         {
            case 0:
               _loc2_ = 109;
               break;
            case 1:
               _loc2_ = 110;
               break;
            case 2:
               _loc2_ = 112;
               break;
            case 3:
               _loc2_ = 111;
         }
         return _loc2_;
      }
   }
}

