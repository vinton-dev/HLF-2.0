# to create config folder
./bin/cryptogen generate --config=./crypto-config.yaml
echo "crypto config succesfully generated"
export FABRIC_CFG_PATH=$PWD
echo "fabric path set"
mkdir channel-artifacts
# Create Genesis Block
./bin/configtxgen -profile FiveOrgsOrdererGenesis  -outputBlock ./channel-artifacts/genesis.block
echo "genesis created"

# export channel name
export AllOrgs_CHANNEL_PROFILE_NAME=AllOrgsChannel
export CHANNEL_AllOrgs_NAME=allorgschannel
export RnCOrgs_CHANNEL_Profile_NAME=AllOrgsChannel
export CHANNEL_RNCOrgs_NAME=rncorgschannel 

./bin/configtxgen -profile ${AllOrgs_CHANNEL_PROFILE_NAME} -outputCreateChannelTx ./channel-artifacts/${CHANNEL_AllOrgs_NAME}.tx -channelID $CHANNEL_AllOrgs_NAME

./bin/configtxgen -profile ${RnCOrgs_CHANNEL_Profile_NAME} -outputCreateChannelTx ./channel-artifacts/${CHANNEL_RNCOrgs_NAME}.tx -channelID $CHANNEL_RNCOrgs_NAME
# Create channel configuration transaction	
echo "CHANNEL_NAME:"$CHANNEL_NAME
#./bin/configtxgen -profile mychannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID $CHANNEL_NAME
echo "Channel transaction created"

# Generating anchor peer transaction for org1

#/bin/configtxgen -profile mychannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org1MSP
./bin/configtxgen -profile ${AllOrgs_CHANNEL_PROFILE_NAME} -outputAnchorPeersUpdate ./channel-artifacts/GrowerMSPanchors_${CHANNEL_AllOrgs_NAME}.tx -channelID $CHANNEL_AllOrgs_NAME -asOrg GrowerMSP
echo "created anchor peer transaction for Grower"

#Generating anchor peer transaction for org2
#./bin/configtxgen -profile mychannel -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org2MSP
./bin/configtxgen -profile ${AllOrgs_CHANNEL_PROFILE_NAME} -outputAnchorPeersUpdate ./channel-artifacts/HarvesterMSPanchors_${CHANNEL_AllOrgs_NAME}.tx -channelID $CHANNEL_AllOrgs_NAME -asOrg HarvesterMSP
echo "created anchor peer transaction for Harvester"

#Generating anchor peer transaction for org3
#./bin/configtxgen -profile mychannel -outputAnchorPeersUpdate ./channel-artifacts/Org3MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org3MSP
./bin/configtxgen -profile ${AllOrgs_CHANNEL_PROFILE_NAME} -outputAnchorPeersUpdate ./channel-artifacts/DistributorMSPanchors_${CHANNEL_AllOrgs_NAME}.tx -channelID $CHANNEL_AllOrgs_NAME -asOrg DistributorMSP
echo "created anchor peer transaction for Distributor"

#Generating anchor peer transaction for org4
#./bin/configtxgen -profile mychannel -outputAnchorPeersUpdate ./channel-artifacts/Org4MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org4MSP
./bin/configtxgen -profile ${AllOrgs_CHANNEL_PROFILE_NAME} -outputAnchorPeersUpdate ./channel-artifacts/RetailerMSPanchors_${CHANNEL_AllOrgs_NAME}.tx -channelID $CHANNEL_AllOrgs_NAME -asOrg RetailerMSP
echo "created anchor peer transaction for org2"

#Generating anchor peer transaction for Customer
#./bin/configtxgen -profile mychannel -outputAnchorPeersUpdate ./channel-artifacts/Org4MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org4MSP
./bin/configtxgen -profile ${AllOrgs_CHANNEL_PROFILE_NAME} -outputAnchorPeersUpdate ./channel-artifacts/CustomerMSPanchors_${CHANNEL_AllOrgs_NAME}.tx -channelID $CHANNEL_AllOrgs_NAME -asOrg CustomerMSP
echo "created anchor peer transaction for org2"


#/bin/configtxgen -profile mychannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org1MSP
#Generating anchor peer transaction for org4
#./bin/configtxgen -profile mychannel -outputAnchorPeersUpdate ./channel-artifacts/Org4MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org4MSP
./bin/configtxgen -profile ${RnCOrgs_CHANNEL_Profile_NAME} -outputAnchorPeersUpdate ./channel-artifacts/RetailerMSPanchors_${CHANNEL_RNCOrgs_NAME}.tx -channelID ${CHANNEL_RNCOrgs_NAME} -asOrg RetailerMSP
echo "created anchor peer transaction for org2"

#Generating anchor peer transaction for Customer
#./bin/configtxgen -profile mychannel -outputAnchorPeersUpdate ./channel-artifacts/Org4MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org4MSP
./bin/configtxgen -profile ${RnCOrgs_CHANNEL_Profile_NAME} -outputAnchorPeersUpdate ./channel-artifacts/CustomerMSPanchors_${CHANNEL_RNCOrgs_NAME}.tx -channelID ${CHANNEL_RNCOrgs_NAME} -asOrg CustomerMSP
echo "created anchor peer transaction for org2"



docker-compose -f docker-compose-cli.yaml -f docker-compose-couch.yaml up -d
#docker-compose -f docker-compose-cli.yaml up -d
#docker container stop $(docker container ls -aq)
#docker container rm $(docker container ls -aq)
#docker logs <container id>


#Environment variables
#CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/grower.orangesprovenance.com/users/Admin@grower.orangesprovenance.com/msp
#CORE_PEER_ADDRESS=peer0.grower.orangesprovenance.com:7051
#CORE_PEER_LOCALMSPID="GrowerMSP"
#CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/grower.orangesprovenance.com/peers/peer0.grower.orangesprovenance.com/tls/ca.crt
#Terminal 1
docker exec -e "CORE_PEER_LOCALMSPID=GrowerMSP" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/grower.orangesprovenance.com/peers/peer0.grower.orangesprovenance.com/tls/ca.crt" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/grower.orangesprovenance.com/users/Admin@grower.orangesprovenance.com/msp" -e "CORE_PEER_ADDRESS=peer0.grower.orangesprovenance.com:7051" -it cli bash
#docker exec -e "CORE_PEER_LOCALMSPID=GrowerMSP" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/grower.orangesprovenance.com/peers/peer1.grower.orangesprovenance.com/tls/ca.crt" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/grower.orangesprovenance.com/users/Admin@grower.orangesprovenance.com/msp" -e "CORE_PEER_ADDRESS=peer1.grower.orangesprovenance.com:7051" -it cli bash
#Terminal 2
docker exec -e "CORE_PEER_LOCALMSPID=HarvesterMSP" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/harvester.orangesprovenance.com/peers/peer0.harvester.orangesprovenance.com/tls/ca.crt" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/harvester.orangesprovenance.com/users/Admin@harvester.orangesprovenance.com/msp" -e "CORE_PEER_ADDRESS=peer0.harvester.orangesprovenance.com:7051" -it cli bash
#Terminal 3
docker exec -e "CORE_PEER_LOCALMSPID=DistributorMSP" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/distributor.orangesprovenance.com/peers/peer0.distributor.orangesprovenance.com/tls/ca.crt" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/distributor.orangesprovenance.com/users/Admin@distributor.orangesprovenance.com/msp" -e "CORE_PEER_ADDRESS=peer0.distributor.orangesprovenance.com:7051" -it cli bash
#Terminal 4
docker exec -e "CORE_PEER_LOCALMSPID=RetailerMSP" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/retailer.orangesprovenance.com/peers/peer0.retailer.orangesprovenance.com/tls/ca.crt" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/retailer.orangesprovenance.com/users/Admin@retailer.orangesprovenance.com/msp" -e "CORE_PEER_ADDRESS=peer0.retailer.orangesprovenance.com:7051" -it cli bash
#Terminal 5
docker exec -e "CORE_PEER_LOCALMSPID=CustomerMSP" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/customer.orangesprovenance.com/peers/peer0.customer.orangesprovenance.com/tls/ca.crt" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/customer.orangesprovenance.com/users/Admin@customer.orangesprovenance.com/msp" -e "CORE_PEER_ADDRESS=peer0.customer.orangesprovenance.com:7051" -it cli bash

# Export orderer ca in all terminals
export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/orangesprovenance.com/orderers/orderer0.orangesprovenance.com/msp/tlscacerts/tlsca.orangesprovenance.com-cert.pem
# create channel block in any one terminal for first channel
peer channel create -o orderer0.orangesprovenance.com:7050 -c allorgschannel -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/allorgschannel.tx --tls --cafile $ORDERER_CA


#terminal 1
 peer channel join -b allorgschannel.block --tls --cafile $ORDERER_CA
 peer channel update -o orderer0.orangesprovenance.com:7050 -c allorgschannel -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/GrowerMSPanchors_allorgschannel.tx --tls --cafile $ORDERER_CA


#terminal 2
 peer channel join -b allorgschannel.block --tls --cafile $ORDERER_CA
 peer channel update -o orderer0.orangesprovenance.com:7050 -c allorgschannel -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/HarvesterMSPanchors_allorgschannel.tx --tls --cafile $ORDERER_CA


#terminal 3
 peer channel join -b allorgschannel.block --tls --cafile $ORDERER_CA
 peer channel update -o orderer0.orangesprovenance.com:7050 -c allorgschannel -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/DistributorMSPanchors_allorgschannel.tx --tls --cafile $ORDERER_CA


#terminal 4
 peer channel join -b allorgschannel.block --tls --cafile $ORDERER_CA
 peer channel update -o orderer0.orangesprovenance.com:7050 -c allorgschannel -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/RetailerMSPanchors_allorgschannel.tx --tls --cafile $ORDERER_CA


#terminal 5
 peer channel join -b allorgschannel.block --tls --cafile $ORDERER_CA
 peer channel update -o orderer0.orangesprovenance.com:7050 -c allorgschannel -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/CustomerMSPanchors_allorgschannel.tx --tls --cafile $ORDERER_CA



 # # create channel block in any one terminal for second channel
 peer channel create -o orderer0.orangesprovenance.com:7050 -c rncorgschannel -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/rncorgschannel.tx --tls --cafile $ORDERER_CA
 #terminal 4
 peer channel join -b rncorgschannel.block --tls --cafile $ORDERER_CA
 peer channel update -o orderer0.orangesprovenance.com:7050 -c rncorgschannel -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/RetailerMSPanchors_rncorgschannel.tx --tls --cafile $ORDERER_CA


#terminal 5
 peer channel join -b rncorgschannel.block --tls --cafile $ORDERER_CA
 peer channel update -o orderer0.orangesprovenance.com:7050 -c rncorgschannel -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/CustomerMSPanchors_rncorgschannel.tx --tls --cafile $ORDERER_CA


#terminal 1 chaincode installation
peer chaincode install -n RegAndLogin31 -v 1.31 -p github.com/chaincode/
peer chaincode instantiate -o orderer0.orangesprovenance.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/orangesprovenance.com/orderers/orderer0.orangesprovenance.com/msp/tlscacerts/tlsca.orangesprovenance.com-cert.pem -C allorgschannel -n RegAndLogin31 -v 1.31  -c '{"Args":[""]}' -P "OR('GrowerMSP.peer')"

CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/grower.orangesprovenance.com/users/Admin@grower.orangesprovenance.com/msp CORE_PEER_ADDRESS=peer0.grower.orangesprovenance.com:7051 CORE_PEER_LOCALMSPID="GrowerMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/grower.orangesprovenance.com/peers/peer0.grower.orangesprovenance.com/tls/ca.crt peer chaincode list --instantiated -C allorgschannel 
peer chaincode invoke -o orderer0.orangesprovenance.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/orangesprovenance.com/orderers/orderer0.orangesprovenance.com/msp/tlscacerts/tlsca.orangesprovenance.com-cert.pem -C allorgschannel -n RegAndLogin31 -c '{"Args":["RegisterGrower","Farm01","Green Growers","9966","aalu@gmail.com","8686","Kaman","Hyd","502032","vinod"]}'

peer chaincode query -C allorgschannel -n RegAndLogin31 -c '{"Args":["getRoleUserById","Grower","Farm01"]}'

peer chaincode invoke -o orderer0.orangesprovenance.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/orangesprovenance.com/orderers/orderer0.orangesprovenance.com/msp/tlscacerts/tlsca.orangesprovenance.com-cert.pem -C allorgschannel -n RegAndLogin31 -c '{"Args":["getRoleUserById","Grower","Farm01"]}'

peer chaincode query -C allorgschannel -n RegAndLogin31 -c '{"Args":["getCountOfTotalGrowers","getCountOfTotalGrowers"]}'

peer chaincode query -C allorgschannel -n RegAndLogin31 -c '{"Args":["CheckUserLogin","Grower","Farm01","vinod"]}'
peer chaincode invoke -o orderer0.orangesprovenance.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/orangesprovenance.com/orderers/orderer0.orangesprovenance.com/msp/tlscacerts/tlsca.orangesprovenance.com-cert.pem -C allorgschannel -n RegAndLogin31 -c '{"Args":["CheckUserLogin","Grower","Farm01","vinod"]}'

#terminal 1 chaincode 2 installation


peer chaincode install -n oranges_batch10 -v 1.10 -p github.com/chaincode/
peer chaincode instantiate -o orderer0.orangesprovenance.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/orangesprovenance.com/orderers/orderer0.orangesprovenance.com/msp/tlscacerts/tlsca.orangesprovenance.com-cert.pem -C allorgschannel -n oranges_batch10 -v 1.10  -c '{"Args":[""]}' -P "OR('GrowerMSP.peer','HarvesterMSP.peer','DistributorMSP.peer','RetailerMSP.peer','CustomerMSP.peer')"

CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/grower.orangesprovenance.com/users/Admin@grower.orangesprovenance.com/msp CORE_PEER_ADDRESS=peer0.grower.orangesprovenance.com:7051 CORE_PEER_LOCALMSPID="GrowerMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/grower.orangesprovenance.com/peers/peer0.grower.orangesprovenance.com/tls/ca.crt peer chaincode list --instantiated -C allorgschannel 
peer chaincode invoke -o orderer0.orangesprovenance.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/orangesprovenance.com/orderers/orderer0.orangesprovenance.com/msp/tlscacerts/tlsca.orangesprovenance.com-cert.pem -C allorgschannel -n oranges_batch10 -c '{"Args":["CreateBatch","batch01","SeedType","SeedBrand","ManufacturerDate","ShelfLife","CertifiedSeeds","Contamination","GeneticallyModified","SoilTexture","SoilPhone","SolubleSalts","OrganicMatter","TestResult","CompositionOfSoil","DeficientComponents","WeedicideUsed","PesticideUsed"]}'

peer chaincode query -C allorgschannel -n oranges_batch10 -c '{"Args":["GetDetails","ViewBatch","batch01"]}' 

peer chaincode invoke -o orderer0.orangesprovenance.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/orangesprovenance.com/orderers/orderer0.orangesprovenance.com/msp/tlscacerts/tlsca.orangesprovenance.com-cert.pem -C allorgschannel -n RegAndLogin16 -c '{"Args":["getRoleUserById","Grower","Green Growers"]}'

peer chaincode query -C allorgschannel -n RegAndLogin16 -c '{"Args":["getCountOfTotalGrowers","getCountOfTotalGrowers"]}'

peer chaincode query -C allorgschannel -n RegAndLogin16 -c '{"Args":["CheckUserLogin","Grower","Farm01","vinod"]}'
peer chaincode invoke -o orderer0.orangesprovenance.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/orangesprovenance.com/orderers/orderer0.orangesprovenance.com/msp/tlscacerts/tlsca.orangesprovenance.com-cert.pem -C allorgschannel -n RegAndLogin16 -c '{"Args":["CheckUserLogin","Grower","Farm01","vinod"]}'
#orange order
peer chaincode invoke -o orderer0.orangesprovenance.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/orangesprovenance.com/orderers/orderer0.orangesprovenance.com/msp/tlscacerts/tlsca.orangesprovenance.com-cert.pem -C allorgschannel -n oranges_batch10 -c '{"Args":["GrowerOrangesOrder","order01","order01","batch01","10days","100","1000","Grower1","26-11-2019"]}'
peer chaincode query -C allorgschannel -n oranges_batch10 -c '{"Args":["GetDetails","ViewOrder","order01"]}'
# Harvester Order
peer chaincode invoke -o orderer0.orangesprovenance.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/orangesprovenance.com/orderers/orderer0.orangesprovenance.com/msp/tlscacerts/tlsca.orangesprovenance.com-cert.pem -C allorgschannel -n oranges_batch10 -c '{"Args":["HarvesterOrangesOrder","order01","100","1000","Harvester01","26-11-2019"]}'
peer chaincode query -C allorgschannel -n oranges_batch10 -c '{"Args":["GetDetails","ViewOrder","order01"]}'

#getAllOrangeBatches
peer chaincode query -C allorgschannel -n oranges_batch10 -c '{"Args":["getAllOrangeBatches","Batch"]}'

#getAllOrangeOrdersBYEntity
peer chaincode query -C allorgschannel -n oranges_batch10 -c '{"Args":["queryOrdersByEntity","GS"]}'

